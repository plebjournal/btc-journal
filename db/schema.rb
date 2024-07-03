# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_01_042108) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "transaction_type", ["buy", "sell", "income", "spend"]

  create_table "current_prices", force: :cascade do |t|
    t.decimal "price"
    t.bigint "fiat_currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiat_currency_id"], name: "index_current_prices_on_fiat_currency_id"
  end

  create_table "fiat_currencies", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "historical_prices", force: :cascade do |t|
    t.datetime "date", null: false
    t.decimal "price", null: false
    t.bigint "fiat_currency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiat_currency_id", "date"], name: "index_historical_prices_on_fiat_currency_id_and_date", unique: true
    t.index ["fiat_currency_id"], name: "index_historical_prices_on_fiat_currency_id"
  end

  create_table "notes", force: :cascade do |t|
    t.decimal "price", null: false
    t.bigint "fiat_currency_id", null: false
    t.text "body", null: false
    t.integer "sentiment", default: 0, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiat_currency_id"], name: "index_notes_on_fiat_currency_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "transaction_date", null: false
    t.bigint "btc", null: false
    t.decimal "fiat"
    t.enum "transaction_type", default: "buy", null: false, enum_type: "transaction_type"
    t.bigint "fiat_currency_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiat_currency_id"], name: "index_transactions_on_fiat_currency_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "time_zone", default: "America/Los_Angeles", null: false
    t.bigint "fiat_currency_id", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fiat_currency_id"], name: "index_user_settings_on_fiat_currency_id"
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "current_prices", "fiat_currencies"
  add_foreign_key "historical_prices", "fiat_currencies"
  add_foreign_key "notes", "fiat_currencies"
  add_foreign_key "notes", "users"
  add_foreign_key "transactions", "fiat_currencies"
  add_foreign_key "transactions", "users"
  add_foreign_key "user_settings", "fiat_currencies"
  add_foreign_key "user_settings", "users"
end
