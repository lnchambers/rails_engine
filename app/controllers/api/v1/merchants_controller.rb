class Api::V1::MerchantsController < ApplicationController
  include ApiMethods
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
  end

  private
    def merchant_params
      params.permit(:id, :name, :created_at, :updated_at)
    end

end
