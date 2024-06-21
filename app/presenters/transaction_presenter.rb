# frozen_string_literal: true

class TransactionPresenter
  def initialize(transaction)
    @transaction = transaction
    @historical_price = HistoricalPrice.for_transaction(@transaction).first
  end

  attr_reader :transaction

  def current_value
    @current_value ||= calculate_current_value
  end

  def original_value
    @transaction.fiat
  end

  def ngu
    (current_value / original_value).round(1)
  end


  private
  def calculate_current_value
    fiat = @transaction.fiat_currency
    current_price = CurrentPrice.find_by(fiat_currency: fiat)
    @transaction.as_btc * current_price.price
  end
end
