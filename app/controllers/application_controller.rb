class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_search
  before_action :set_merchant_search

  def set_search
    @search = Search.new
  end

  def set_merchant_search
    @merchantsearch = MerchantSearch.new
  end

  def set_customer_search
    @customersearch = CustomerSearch.new
  end

  def set_transaction_search
    @transactionsearch = TransactionSearch.new
  end
end
