# frozen_string_literal: true

class PriceRefresh::RefreshHistoricalPrices
  CRYPTO_COMPARE_API = 'https://min-api.cryptocompare.com/data/v2/histohour'
  MIN_HISTORICAL_DATE = Time.at(1281081600, in: 'UTC')

  def initialize(fiat_currency)
    @fiat_currency = fiat_currency
  end

  def self.call(fiat_currency)
    new(fiat_currency).refresh
  end

  def refresh
    refresh_history(@fiat_currency)
  end

  private

  def refresh_history(fiat_currency)
    if blank_history_for?(fiat_currency)
      Rails.logger.info "no existing prices found, updating full history for #{fiat_currency.code}"
      full_history(fiat_currency)
    else
      update_to_latest(fiat_currency)
    end
  end

  def blank_history_for?(fiat_currency)
    not HistoricalPrice.where(fiat_currency: fiat_currency).any?
  end

  def full_history(fiat_currency)
    prices = fetch_ordered(fiat_currency, DateTime.now)
    while prices.first[:date] >= MIN_HISTORICAL_DATE && prices.first[:price] > 0.0
      Rails.logger.info "inserting #{prices.length} historical prices"
      HistoricalPrice.upsert_all(prices, unique_by: [:fiat_currency_id, :date])
      Rails.logger.info 'done inserting prices'
      prices = fetch_ordered(fiat_currency, Time.at(prices.first[:date], in: 'UTC'))
    end
  end

  def update_to_latest(fiat_currency)
    last_time_stamp = most_recent_historical_price(fiat_currency)

    prices = fetch_ordered(fiat_currency, DateTime.now)
    while prices.any? && prices.last[:date] > last_time_stamp
      mapped = prices.filter {|price| price[:date] > last_time_stamp }
      Rails.logger.info "inserting #{mapped.length} historical prices"
      HistoricalPrice.upsert_all(mapped, unique_by: [:date, :fiat_currency_id])
      Rails.logger.info 'done inserting prices'
      last_time_stamp = most_recent_historical_price(fiat_currency)
      prices = fetch_ordered(fiat_currency, mapped.last[:date].to_i)
    end
  end

  def most_recent_historical_price(fiat_currency)
    HistoricalPrice.where(fiat_currency: fiat_currency).order(:date).last.date
  end

  def fetch_ordered(fiat_currency, date)
    prices = fetch(fiat_currency, date)
    mapped =
      prices.map do |price|
        {
          date: Time.at(price['time'], in: 'UTC'),
          price: price['close'],
          fiat_currency_id: fiat_currency.id,
        }
      end
    mapped.sort_by! { |price| price[:date] }
  end

  def fetch(fiat_currency, to_time)
    Rails.logger.info 'fetching historical prices from crypto-compare api'
    response =
      HTTParty.get(
        CRYPTO_COMPARE_API, {
        query: {
          fsym: 'BTC',
          tsym: fiat_currency.code,
          limit: 2000,
          toTs: to_time.to_i
        }
      })
    Rails.logger.info 'done fetching'
    response.dig('Data', 'Data')
  end
end
