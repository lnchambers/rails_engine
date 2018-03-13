class InvoiceItem < ApplicationRecord
  validates_presence_of :unit_price, :quantity
  belongs_to :item
  belongs_to :invoice
end
