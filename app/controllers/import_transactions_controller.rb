require 'csv'

class ImportTransactionsController < ApplicationController
  def index
  end

  def upload
    csv_file = params[:transactions_file]
    if csv_file
      @csv = csv_file.read
      table = CSV.parse(@csv, headers: true)
      if table
        @transactions_to_import = table.map { |row| parse_transaction(row) }
      end
    end
  end

  def create
    txs = transaction_params
    txs.each do |tx_params|
      tx = Transaction.new(tx_params)
      tx.transaction_date = tx.transaction_date.in_time_zone(current_user.local_zone)
      tx.user = current_user
      tx.save!
    end
    redirect_to transactions_path, notice: "#{txs.count} Transactions were successfully imported."
  end

  private

  def transaction_params
    params
      .require(:transaction)
      .permit({ transaction: [:transaction_date, :transaction_type, :btc, :fiat, :fiat_currency_id] })
      .fetch(:transaction)
  end


  def parse_transaction(table_row)
    user_id = current_user.id

    Transaction.new(
      transaction_date: table_row['transaction_date'],
      btc: table_row['btc'],
      fiat: table_row['fiat'],
      transaction_type: table_row['transaction_type'],
      fiat_currency_id: parse_fiat(table_row['fiat_currency']),
      user_id: user_id
    )
  end

  def parse_fiat(fiat_code)
    case fiat_code
    when 'CAD'
      FiatCurrency.where(code: 'CAD').first.id
    when 'USD'
      FiatCurrency.where(code: 'USD').first.id
    else
      raise StandardError, "Unknown fiat code #{fiat_code}"
    end
  end
end
