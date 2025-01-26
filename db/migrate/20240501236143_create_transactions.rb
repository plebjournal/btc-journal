class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.datetime :transaction_date, null: false
      t.bigint :btc, null: false
      t.decimal :fiat
      t.string :transaction_type, default: 'buy', null: false
      t.references :fiat_currency, foreign_key: true, null: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
