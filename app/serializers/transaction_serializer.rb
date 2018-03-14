class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :credit_card_number, :result
  belongs_to :invoice
  belongs_to :customer
end
