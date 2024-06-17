# frozen_string_literal: true

class Queries

  def self.moving_total_fiat_value(user, end_date)
    start_date = user.transactions.order(:transaction_date).first&.transaction_date
    return [] if start_date.blank?
    historical_prices =
      HistoricalPrice.where(date: start_date..end_date)
                     .where(fiat_currency: user.fiat_currency)
                     .where('extract(hour from date) = 0')
                     .order(:date).to_a
    sum = UserTransactionsMovingSum.for_user(user)
    historical = historical_prices.map do |price|
      {
        time: price.date.to_i,
        value: (sum.btc_at_date(price.date) * price.price).round
      }
    end
    latest = {
      time: DateTime.current.to_i,
      value: (sum.btc_at_date(DateTime.current) * CurrentPrice.where(fiat_currency: user.fiat_currency).first.price).round
    }
    historical << latest
  end

  def self.moving_total_btc_stack(user, end_date)
    start_date = user.transactions.order(:transaction_date).first&.transaction_date
    return [] if start_date.blank?

    sum = UserTransactionsMovingSum.for_user(user)
    range = (start_date.tomorrow.to_date .. Date.current).to_a
    full_date_range = range.prepend(start_date).append(DateTime.current)
    historical = full_date_range.map do |date|
      {
        time: date.to_time.to_i,
        value: sum.btc_at_date(date)
      }
    end

    historical
  end

  def self.get_date_range(start_date_time)
    range = (start_date_time.tomorrow.to_date .. Date.current).to_a
    range.prepend(start_date_time).append(DateTime.current)
  end
end
