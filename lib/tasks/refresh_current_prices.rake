namespace :refresh_current_prices do
  desc 'Refresh Current Price for CAD and USD'
  COIN_GECKO_API = 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart'

  task cad: :environment do
    Rails.logger.info 'Refreshing Current Price'
    perform('CAD')
  end

  task usd: :environment do
    Rails.logger.info 'Refreshing Current Price'
    perform('USD')
  end

  def perform(fiat_code)
    Rails.logger.info "refreshing price for #{fiat_code}..."
    currency = FiatCurrency.find_by_code(fiat_code)
    response = HTTParty.get(COIN_GECKO_API, { query: { vs_currency: currency.code, days: 0 } })
    Rails.logger.info "fetched price for #{currency.code}"
    prices = response['prices']
    if prices&.first&.present? && prices.first.length
      price = prices.first.second
      Rails.logger.info "updating #{currency.code} price to #{price}"
      upsert_price(currency, price)
      Rails.logger.info "finished updating price for #{currency.code}"
    end
    Rails.logger.info 'finished refreshing prices'
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
