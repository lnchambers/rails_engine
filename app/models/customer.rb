class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants
      .select("merchants.*, COUNT(transactions.id) as transaction_count")
      .joins(invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("transaction_count DESC").first
  end
end
