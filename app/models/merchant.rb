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

  def self.most_items(limit = 5)
    select("merchants.*, sum(invoice_items.item_id * invoice_items.quantity) AS solditems")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .order("solditems DESC").limit(limit)
      .group(:id)
  end

  def self.revenue_by_date(date)
    select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where(transactions: {created_at: date})
      .first
      .revenue
  end

  def self.top_revenue(id)
    select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where(id: id)
      .first
      .revenue
  end

  def self.top_revenue_by_date(id, date)
    select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .where(id: id)
      .where(invoices: {created_at: date})
      .first
      .revenue
  end
end
