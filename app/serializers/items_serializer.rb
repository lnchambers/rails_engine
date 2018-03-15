class ItemsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price
end
