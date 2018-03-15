class Api::V1::Transactions::TransactionsController < ApplicationController

  def index
    render json: @search.route(params, Transaction)
  end

  def show
    render json: @search.route(params, Transaction)
  end

end
