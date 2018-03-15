class Transaction < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :customer, optional: true
  validates_presence_of(:credit_card_number)
  validates_presence_of(:result)

  scope :successful, -> { where(result: 'success')}
  scope :not_successful, -> { where(result: 'failed')}

  default_scope { order(:id) }

  def self.total_revenue_by_date(date)
    date = DateTime.strptime(date, "%Y-%m-%d")
    select("transactions.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(invoice: [:invoice_items])
    .merge(Transaction.unscoped.successful)
    .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
    .group(:id).sum(&:revenue)
  end
end
