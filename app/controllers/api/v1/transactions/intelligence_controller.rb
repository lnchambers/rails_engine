class Api::V1::Transactions::IntelligenceController < ApplicationController
  before_action :set_intelligence

  def show
    render json: @transaction_intelligence.route(params)
  end

  private

    def set_intelligence
      @transaction_intelligence = TransactionIntelligence.new
    end

end
