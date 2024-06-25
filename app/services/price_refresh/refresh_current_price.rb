# frozen_string_literal: true

class PriceRefresh::RefreshCurrentPrice
  COIN_GECKO_API = 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart'

  def initialize(fiat_currency)
    @fiat_currency = fiat_currency
  end

  def self.call(fiat_currency)
    new(fiat_currency).refresh
  end

  def refresh
    response = HTTParty.get(COIN_GECKO_API, { query: { vs_currency: @fiat_currency.code, days: 0 } })
    Rails.logger.info "fetched price for #{@fiat_currency.code}"
    prices = response['prices']
    if prices&.first&.present? && prices.first.length
      price = prices.first.second
      Rails.logger.info "updating #{@fiat_currency.code} price to #{price}"
      upsert_price(@fiat_currency, price)
      Rails.logger.info "finished updating price for #{@fiat_currency.code}"
    end
  end

  def upsert_price(currency, price)
    current_price = CurrentPrice.find_by(fiat_currency_id: currency.id)
    if current_price.present?
      current_price.update!(price: price)
    else
      CurrentPrice.create!({ price: price, fiat_currency_id: currency.id })
    end
  end
end
