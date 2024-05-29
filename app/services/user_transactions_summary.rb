# frozen_string_literal: true

module UserTransactionsSummary
  def self.summarize(user)
    memo = TransactionsSummarizer.new(user)
    user.transactions.reduce(memo, :add_tx)
  end

  class TransactionsSummarizer

    # initialize summarizer
    def initialize(user)
      @user = user
      @total_btc = 0
      @total_fiat = 0.0
    end

    def add_tx(transaction)
      if transaction.buy? || transaction.income?
        @total_btc += transaction.btc
        @total_fiat += transaction.fiat
      elsif transaction.sell? || transaction.spend?
        @total_btc -= transaction.btc
        @total_fiat -= transaction.fiat
      end
      self
    end

    def sats
      @total_btc
    end

    def btc
      @total_btc.to_f / 100_000_000.to_f
    end

    def fiat
      @total_fiat
    end

    def ngu
      current_value = btc * @user.fiat_currency.current_price.price
      current_value / @total_fiat
    end
  end
end
