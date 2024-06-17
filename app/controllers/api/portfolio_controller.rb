class Api::PortfolioController < ApplicationController
  def index
    res = Queries.moving_total_btc_stack(current_user, DateTime.current)
    render json: res
  end
end
