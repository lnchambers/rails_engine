class Api::V1::Items::ItemsController < ApplicationController

  def index
    render json: @search.route(params, Item)
  end

  def show
    render json: @search.route(params, Item)
  end

end
