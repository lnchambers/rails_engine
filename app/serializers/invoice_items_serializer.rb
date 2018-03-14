class InvoiceItemsSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :unit_price, :quantity
  
end
