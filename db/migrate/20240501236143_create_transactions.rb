class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_enum :transaction_type, ['buy', 'sell', 'income', 'spend']
    create_table :transactions do |t|
      t.datetime :transaction_date, null: false
      t.bigint :btc, null: false
      t.decimal :fiat
      t.enum :transaction_type, enum_type: :transaction_type, default: 'buy', null: false
      t.references :fiat_currency, foreign_key: true, null: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
