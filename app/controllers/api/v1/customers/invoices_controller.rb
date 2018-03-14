class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    customer = Customer.find(params[:customer_id])
    render json: customer.invoices
  end

end
