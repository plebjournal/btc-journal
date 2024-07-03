class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.numeric 'price', null: false
      t.references :fiat_currency, null: false, foreign_key: true
      t.text 'body', null: false
      t.integer 'sentiment', null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
