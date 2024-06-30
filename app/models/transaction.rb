class Transaction < ApplicationRecord
  belongs_to :fiat_currency
  belongs_to :user, inverse_of: :transactions

  validates :transaction_date, presence: true
  validates :btc, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :fiat, numericality: { greater_than_or_equal_to: 0 } if present?

  enum transaction_type: {
    buy: 'buy',
    sell: 'sell',
    income: 'income',
    spend: 'spend'
  }

  def self.for_user(user)
    user.transactions.includes(:fiat_currency)
  end

  def as_sats
    btc
  end

  def as_btc
    btc.to_f / 100_000_000.to_f
  end

  def local_transaction_date
    user.local_zone.to_local(transaction_date)
  end

  def self.ransackable_attributes(auth_object = nil)
    ['transaction_date', 'btc', 'fiat', 'transaction_type']
  end
end
