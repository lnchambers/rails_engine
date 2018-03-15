class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_revenue(limit = 5)
    select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .order("revenue DESC").limit(limit)
      .group(:id)
  end

  def favorite_customer
    Customer.select("customers.*, count(invoices.merchant_id) AS merchants").join(:invoices, :transactions).merge(Transaction.unscoped.successful).order("merchants DESC").limit(1)
  end
end
