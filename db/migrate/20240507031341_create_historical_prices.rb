class CreateHistoricalPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :historical_prices do |t|
      t.datetime :date, null: false
      t.numeric :price, null: false
      t.references :fiat_currency, index: true, foreign_key: true, null: false
      t.timestamps
      t.index [:fiat_currency_id, :date], unique: true
    end
  end
end
