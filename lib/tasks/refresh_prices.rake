namespace :refresh_prices do
  desc 'Refresh Prices for CAD and USD'
  task all_fiat_prices: :environment do
    FiatCurrency.all.each do |currency|
      Rails.logger.info "refreshing price for #{currency.code}..."
      PriceRefresh::RefreshCurrentPrice.call(currency)

      current_hour = Time.current.hour
      Rails.logger.info "current hour: #{current_hour}"
      if current_hour % 8 == 0
        Rails.logger.info "refreshing historical prices for #{currency.code}..."
        PriceRefresh::RefreshHistoricalPrices.call(currency)
      end
    end
  end
end
