class Api::V1::MerchantsController < ApplicationController
  
  def index
    render json: Merchant.all
  end

  def show
    render json: @merchantsearch.route(params)
  end

  private
    def merchant_params
      params.permit(:id, :name, :created_at, :updated_at)
    end

end
