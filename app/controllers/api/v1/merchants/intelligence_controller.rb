class Api::V1::Merchants::IntelligenceController < ApplicationController
  before_action :set_intelligence

  def index
    render json: @merchant_intelligence.route(params, request)
  end

  def show
    render json: @merchant_intelligence.route(params, request)
  end

  private

    def set_intelligence
      @merchant_intelligence = MerchantIntelligence.new
    end

end
