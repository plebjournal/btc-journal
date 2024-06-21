class SeedFiatCurrencies < ActiveRecord::Migration[7.1]
  def up
    FiatCurrency.find_or_create_by!(name: 'Canadian Dollar', code: 'CAD')
    FiatCurrency.find_or_create_by!(name: 'United States Dollar', code: 'USD')
  end

  def down
    FiatCurrency.all.each(&:destroy!)
  end
end
