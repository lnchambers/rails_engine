class Api::V1::Items::IntelligenceController < ApplicationController
  before_action :set_intelligence

  def index
    render json: @item_intelligence.route(params, request)
  end

  def show
    render json: @item_intelligence.route(params, request)
  end

  private

    def set_intelligence
      @item_intelligence = ItemIntelligence.new
    end

end
