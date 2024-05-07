# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @prices = CurrentPrice.includes(:fiat_currency).all
  end
end
