# frozen_string_literal: true

class UserTransactionsMovingSum
  def initialize
    @moving_sum = []
  end

  def add_txs(transactions)
    transactions.sort_by(&:transaction_date).each do |transaction|
      add_tx(transaction)
    end
    self
  end

  def self.for_user(user)
    txs = user.transactions.order(:transaction_date)
    self.new.add_txs(txs)
  end

  def btc_at_date(date)
    moving_sum = @moving_sum.filter { |m| m.date <= date }.last
    moving_sum.total_btc if moving_sum.present?
  end

  def fiat_at_date(date)
    moving_sum = @moving_sum.filter { |m| m.date <= date }.last
    moving_sum.total_fiat if moving_sum.present?
  end

  private

  def add_tx(transaction)
    sats_amount = next_sats_amount(transaction)
    fiat_amount = next_fiat_amount(transaction)
    @moving_sum << MovingSum.new(transaction.transaction_date, sats_amount, fiat_amount)
  end

  def next_sats_amount(transaction)
    if transaction.buy? || transaction.income?
      if @moving_sum.empty?
        return transaction.btc
      end
      @moving_sum.last.total_sats + transaction.btc
    elsif transaction.sell? || transaction.spend?
      if @moving_sum.empty?
        return transaction.btc * -1.0
      end
      @moving_sum.last.total_sats - transaction.btc
    end
  end

  def next_fiat_amount(transaction)
    if transaction.buy?
      if @moving_sum.empty?
        return transaction.fiat
      end
      @moving_sum.last.total_fiat + (transaction.fiat || 0.0)
    elsif transaction.sell?
      if @moving_sum.empty?
        return transaction.fiat * -1.0
      end
      @moving_sum.last.total_fiat - (transaction.fiat || 0.0)
    else
      @moving_sum.last&.total_fiat || 0.0
    end
  end

  class MovingSum
    def initialize(date, total_sats, total_fiat)
      @date = date
      @total_sats = total_sats
      @total_btc = total_sats.to_f / 100_000_000.to_f
      @total_fiat = total_fiat
    end

    attr_reader :date, :total_btc, :total_sats, :total_fiat
  end
end
