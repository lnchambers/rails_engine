class Api::V1::Customers::CustomersController < ApplicationController
  def index
    render json: @search.route(params, Customer)
  end

  def show
    render json: @search.route(params, Customer)
  end
end
