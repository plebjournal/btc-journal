class Transaction < ApplicationRecord
  belongs_to :fiat_currency
  belongs_to :user, inverse_of: :transactions

  validates :transaction_date, presence: true
  validates :btc, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validate :validate_fiat

  enum transaction_type: {
    buy: 'buy',
    sell: 'sell',
    income: 'income',
    spend: 'spend'
  }

  def self.for_user(user)
    user.transactions.includes(:fiat_currency)
  end

  def self.create_for_user(user, params)
    btc = params[:btc].to_d
    if params[:btc_unit] == 'BTC'
      btc *= 100_000_000
    end
    Transaction.new({
      btc: btc,
      fiat: params[:fiat],
      fiat_currency_id: params[:fiat_currency_id],
      user: user,
      transaction_date: params[:transaction_date].in_time_zone(user.local_zone),
    })
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

  private

  def validate_fiat
    if fiat.present? && fiat < 0
      errors.add(:fiat, 'must be greater than or equal to 0')
    end
  end
end
