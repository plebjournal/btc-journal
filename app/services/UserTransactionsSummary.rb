# frozen_string_literal: true

module UserTransactionsSummary
  def self.summarize(user)
    memo = TransactionsSummarizer.new
    user.transactions.reduce(memo, :add_tx)
  end

  class TransactionsSummarizer

    # initialize summarizer
    def initialize
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

    def btc
      @total_btc
    end

    def fiat
      @total_fiat
    end
  end
end
