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

  private

  def add_tx(transaction)
    amount = next_amount(transaction)
    @moving_sum << MovingSum.new(transaction.transaction_date, amount)
  end

  def next_amount(transaction)
    if transaction.buy? || transaction.income?
      if @moving_sum.empty?
        return transaction.btc
      end
      @moving_sum.last.total_btc + transaction.btc
    elsif transaction.sell? || transaction.spend?
      if @moving_sum.empty?
        return transaction.btc * -1.0
      end
      @moving_sum.last.total_btc - transaction.btc
    end
  end

  class MovingSum
    def initialize(date, total)
      @date = date
      @total_sats = total
      @total_btc = total.to_f / 100_000_000.to_f
    end

    attr_reader :date, :total_btc, :total_sats
  end

end
