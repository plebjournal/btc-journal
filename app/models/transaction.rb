class Transaction < ApplicationRecord
  belongs_to :fiat_currency
  belongs_to :user, inverse_of: :transactions

  enum transaction_type: {
    buy: 'buy',
    sell: 'sell',
    income: 'income',
    spend: 'spend'
  }
end
