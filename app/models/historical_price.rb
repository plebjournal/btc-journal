class HistoricalPrice < ApplicationRecord
  belongs_to :fiat_currency

  def self.for_transaction(transaction)
    HistoricalPrice
      .where('date >= ?', transaction.transaction_date)
      .where(fiat_currency_id: transaction.fiat_currency_id)
      .order('date asc')
      .limit(1)
  end
end
