class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :credit_card_number, :result
end
