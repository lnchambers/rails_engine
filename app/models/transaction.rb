class Transaction < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  validates_presence_of(:credit_card_number)
  validates_presence_of(:result)

  scope :successful, -> { where(result: 'success')}
  scope :not_successful, -> { where(result: 'failed')}

  default_scope { order(:id) }
end
