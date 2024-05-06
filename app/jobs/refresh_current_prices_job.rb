class RefreshCurrentPricesJob < ApplicationJob
  queue_as :current_prices

  COIN_GECKO_API = 'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart'

  def perform
    logger.info 'refreshing prices...'
    fiat_currencies = FiatCurrency.all
    fiat_currencies.each do |currency|
      response = HTTParty.get(COIN_GECKO_API, { query: { vs_currency: currency.code, days: 0 } })
      logger.info "fetched price for #{currency.code}"
      prices = response['prices']
      if prices&.first&.present? && prices.first.length
        price = prices.first.second
        logger.info "updating #{currency.code} price to #{price}"
        upsert_price(currency, price)
        logger.info "finished updating price for #{currency.code}"
      end
    end
    logger.info 'finished refreshing prices'
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
