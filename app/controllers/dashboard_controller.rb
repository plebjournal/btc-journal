class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_prices = CurrentPrice.includes(:fiat_currency).all
    @summary = UserTransactionsSummary.summarize(current_user)
  end
end
