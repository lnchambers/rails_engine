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
end
