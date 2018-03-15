class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(limit = 5)
    select("items.*, count(invoice_items.item_id) as solditems")
    .joins(:invoice_items)
    .order("solditems DESC").limit(limit)
    .group(:id)
  end


  def self.best_day(id)
    select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS sales")
    .joins(:invoice_items)
    .where(id: id)
    .order("sales DESC")
    .first
    .created_at
  end

  def best_day
    invoices.select("invoices.created_at, sum(invoice_items.quantity) as sum")
      .joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("sum DESC")
  end
end
