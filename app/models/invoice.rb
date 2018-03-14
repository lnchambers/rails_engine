class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
<<<<<<< HEAD
  has_many :transactions
=======

  def self.most_expensive(limit = 5)
    select("invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .order("revenue DESC").limit(limit)
      .group(:id)
  end


>>>>>>> adds serializers
end
