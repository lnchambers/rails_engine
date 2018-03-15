class Api::V1::InvoiceItems::InvoiceItemsController < ApplicationController

  def index
    render json: @search.route(params, InvoiceItem)
  end

  def show
    render json: @search.route(params, InvoiceItem)
  end

end
