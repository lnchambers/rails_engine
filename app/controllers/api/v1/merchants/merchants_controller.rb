class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    render json: @search.route(params, Merchant)
  end

  def show
    render json: @search.route(params, Merchant)
  end
end
