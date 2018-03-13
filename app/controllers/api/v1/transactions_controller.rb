class Api::V1::TransactionsController < ApplicationController
  def index
    render json: Transaction.all
  end

  def show
    render json: @search.route(params, Transaction)
  end
end
