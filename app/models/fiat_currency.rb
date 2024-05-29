class FiatCurrency < ApplicationRecord
  has_many :transactions, foreign_key: :fiat_currency_id
  has_many :user_settings, foreign_key: :fiat_currency_id
  has_one :current_price
end
