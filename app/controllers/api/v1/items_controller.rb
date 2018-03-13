class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  def show
    binding.pry
    render json: Item.where("#{params.keys[0]} LIKE ?", params.values[0])
  end

end
