class FiatCurrency < ApplicationRecord
  has_many :transactions, foreign_key: :fiat_currency_id
end
