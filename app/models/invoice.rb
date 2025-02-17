class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  validates_presence_of :status

  enum status: ["in progress", "cancelled", "completed"]

  def self.uniq_invoices
    distinct
  end

  def my_total_revenue(merchant)
    invoice_items.joins(:item)
                  .where(invoice_items: {invoice_id: self.id})
                  .where(items: {merchant_id: merchant.id})
                  .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def my_total_revenue_formatter(merchant)
    "%.2f" % my_total_revenue(merchant)
  end

  def admin_total_revenue(invoice_name)
    invoice_items.joins(:invoice)
    .where(invoice_items: {invoice_id: self.id})
    .where(invoices: {id: invoice_name.id})
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.incomplete_invoices
    joins(:invoice_items).where("invoice_items.status != ?", 2).distinct.order(:created_at)
  end

  def discounted_revenue(merchant)
    invoice_items.joins(merchants: :bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity_threshold")
    .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (bulk_discounts.percentage_discount / 100.0)) as total_discount')
    .group('invoice_items.id')
    .sum(&:total_discount)
  end



end
