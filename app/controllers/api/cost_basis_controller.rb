class Api::CostBasisController < ApplicationController
  def index
    res = Queries.moving_total_cost_basis(current_user, DateTime.current)
    render json: res
  end
end
