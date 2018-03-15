class Api::V1::Invoices::InvoicesController < ApplicationController

  def index
    render json: @search.route(params, Invoice)
  end

  def show
    render json: @search.route(params, Invoice)
  end

end
