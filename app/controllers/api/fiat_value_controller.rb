class Api::FiatValueController < ApplicationController
  def index
    res = Queries.moving_total_fiat_value(current_user, params.require(:start_date), DateTime.current)
    render json: res
  end
end
