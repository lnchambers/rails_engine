class Api::V1::Customers::IntelligenceController < ApplicationController
  before_action :set_intelligence

  def show
    render json: @customer_intelligence.route(params, request)
  end

  private

    def set_intelligence
      @customer_intelligence = CustomerIntelligence.new
    end

end
