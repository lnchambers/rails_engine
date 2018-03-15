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
    start_day = DateTime.parse(date).beginning_of_day
    end_day  = DateTime.parse(date).end_of_day
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .where(transactions: {updated_at: start_day..end_day})
      .group(:id)
      .order("revenue DESC")
  end

  def total_revenue
    invoice_items.joins(invoice: [:transactions])
      .merge(Transaction.unscoped.successful)
      .sum("unit_price * quantity")
  end


  def top_revenue_by_date(date)
    start_day = DateTime.parse(date).beginning_of_day
    end_day  = DateTime.parse(date).end_of_day
    invoice_items
    .joins(invoice: :transactions)
    .merge(Transaction.unscoped.successful)
    .where(invoices: {updated_at: start_day..end_day})
    .sum("unit_price * quantity")
  end

end
