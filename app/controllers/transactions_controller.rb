class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /transactions or /transactions.json
  def index
    @q = current_user.transactions.includes(:fiat_currency).ransack(params[:q])
    @q.sorts = 'transaction_date desc' if @q.sorts.empty?
    @transactions = @q.result.page(params[:page])
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params.require(:id))
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.create_for_user(current_user, transaction_params)
    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      transaction_update = transaction_params
      if transaction_update[:btc_unit] == 'BTC'
        transaction_update[:btc] = transaction_update[:btc] * 100_000_000
      end
      if @transaction.update(transaction_update.except(:btc_unit))
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.includes(:fiat_currency).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.fetch(:transaction, {}).permit(required_params)
    end

    def required_params
      [:transaction_date, :btc, :btc_unit, :fiat, :transaction_type, :fiat_currency_id]
    end
end
