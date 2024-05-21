# frozen_string_literal: true

class Queries
  def self.total_stack(user, date)
    transactions = user.transactions.where('transaction_date <= ?', date)
    memo = UserTransactionsSummary::TransactionsSummarizer.new
    transactions.reduce(memo, :add_tx)
  end

  def self.moving_total_fiat_value(user, end_date)
    start_date = user.transactions.order(:transaction_date).first.transaction_date
    historical_prices =
      HistoricalPrice.where(date: start_date..end_date)
                     .where(fiat_currency_id: 1)
                     .where('extract(hour from date) = 0')
                     .order(:date).to_a
    sum = UserTransactionsMovingSum.for_user(user)
    historical_prices.map do |price|
      {
        time: price.date.to_i,
        value: (sum.btc_at_date(price.date) * price.price).round
      }
    end
  end
end
