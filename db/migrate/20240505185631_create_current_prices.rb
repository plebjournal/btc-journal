class CreateCurrentPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :current_prices do |t|
      t.numeric 'price'
      t.references :fiat_currency, index: true, foreign_key: true
      t.timestamps
    end
  end
end
