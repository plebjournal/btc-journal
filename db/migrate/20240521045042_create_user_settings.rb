class CreateUserSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :user_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :time_zone, null: false, default: "America/Los_Angeles"
      t.references :fiat_currency, null: false, foreign_key: true, default: 1
      t.timestamps
    end
  end
end
