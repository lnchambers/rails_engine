class ItemsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price
  has_many :invoice_items
end
