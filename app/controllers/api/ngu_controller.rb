class Api::NguController < ApplicationController
  def index
    res = Queries.moving_ngu(current_user, DateTime.current)
    render json: res
  end
end
