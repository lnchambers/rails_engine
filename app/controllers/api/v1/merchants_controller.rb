class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    render json: @merchantsearch.route(params)
  end
end
