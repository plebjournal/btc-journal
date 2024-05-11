# frozen_string_literal: true

class TransactionListPresenter
  def initialize(transactions)
    @transactions = transactions
  end

  def decorated_transactions
    @transactions.map do |transaction|
      TransactionPresenter.new(transaction)
    end
  end
end
