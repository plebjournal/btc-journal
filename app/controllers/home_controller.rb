# frozen_string_literal: true

class HomeController < ActionController::Base
  def index
    if current_user
      redirect_to :dashboard
    end
    @prices = CurrentPrice.includes(:fiat_currency).all
  end
end
