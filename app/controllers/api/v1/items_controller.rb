class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    render json: @item_search.route(params)
  end

end
