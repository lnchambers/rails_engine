class Transaction < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  validates_presence_of(:credit_card_number)
  validates_presence_of(:result)
end
