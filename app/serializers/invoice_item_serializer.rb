class InvoiceItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :invoice_id, :unit_price, :quantity

  def unit_price
    '%.2f' % (object.unit_price.to_f / 100)
  end
end
