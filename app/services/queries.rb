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

    historical_prices =
      HistoricalPrice.where(date: start_date..end_date)
                     .where(fiat_currency: user.fiat_currency)
                     .where('extract(hour from date) = 0')
                     .order(:date).to_a

    sum = UserTransactionsMovingSum.for_user(user)
    historical = historical_prices.map do |price|
      {
        time: price.date.to_i,
        value: sum.btc_at_date(price.date)
      }
    end

    latest = {
      time: DateTime.current.to_i,
      value: sum.btc_at_date(DateTime.current)
    }
    historical << latest
  end

  def self.moving_total_cost_basis(user, end_date)
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
        value: sum.fiat_at_date(price.date)
      }
    end

    latest = {
      time: DateTime.current.to_i,
      value: sum.fiat_at_date(DateTime.current)
    }
    historical << latest
  end

  def self.moving_ngu(user, end_date)
    start_date = user.transactions.order(:transaction_date).first&.transaction_date
    return [] if start_date.blank?

    historical_prices =
      HistoricalPrice.where(date: start_date..end_date)
                     .where(fiat_currency: user.fiat_currency)
                     .where('extract(hour from date) = 0')
                     .order(:date).to_a

    sum = UserTransactionsMovingSum.for_user(user)
    historical = historical_prices.map do |price|
      ngu = (sum.btc_at_date(price.date) * price.price) / sum.fiat_at_date(price.date)
      {
        time: price.date.to_i,
        value: ngu.round(1)
      }
    end

    latest = {
      time: DateTime.current.to_i,
      value: ((sum.btc_at_date(DateTime.current) * user.fiat_currency.current_price.price) / sum.fiat_at_date(DateTime.current)).round(1)
    }
    historical << latest
  end
end
