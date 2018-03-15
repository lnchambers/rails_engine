class Api::V1::Merchants::MerchantsController < ApplicationController
  before_action :set_merchant_search

  def index
    render json: @merchant_search.route(params)
  end

  def show
    render json: @merchant_search.route(params)
  end

  private
    def set_merchant_search
      @merchant_search = MerchantSearch.new
    end
end
