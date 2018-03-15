class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(limit = 5)
    select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .order("revenue DESC").limit(limit)
      .group(:id)
  end

  def self.most_items(limit = 5)
    select("merchants.*, sum(invoice_items.quantity) AS solditems")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("solditems DESC").limit(limit)
  end


  def total_revenue
    invoice_items.joins(invoice: [:transactions])
      .merge(Transaction.unscoped.successful)
      .sum("unit_price * quantity")
  end


  def top_revenue_by_date(date)
    start_day = DateTime.parse(date).beginning_of_day
    end_day  = DateTime.parse(date).end_of_day
    invoice_items
      .joins(invoice: :transactions)
      .merge(Transaction.unscoped.successful)
      .where(invoices: {updated_at: start_day..end_day})
      .sum("unit_price * quantity")
  end

  def favorite_customer
    customers
      .select("customers.*, COUNT(transactions.id) as transaction_count")
      .joins(invoices: [:transactions])
      .merge(Transaction.unscoped.successful)
      .group(:id)
      .order("transaction_count DESC").first
  end

  def customers_with_pending_invoices
    customers.find_by_sql(
      "SELECT customers.* FROM customers
        JOIN invoices ON invoices.customer_id = customers.id
        JOIN transactions ON transactions.invoice_id = invoices.id
        WHERE transactions.result = 'failed'
        AND invoices.merchant_id = #{self.id}
        EXCEPT
        SELECT customers.* FROM customers
        JOIN invoices ON invoices.customer_id = customers.id
        JOIN transactions ON transactions.invoice_id = invoices.id
        WHERE transactions.result = 'success'
        AND invoices.merchant_id = #{self.id}"
    )
  end
end
