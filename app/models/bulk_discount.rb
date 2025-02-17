class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :percentage_discount, :quantity_threshold, :presence => true
  validates :percentage_discount, :quantity_threshold, :numericality => true

  # def self.find_bd(quantity)
  #   where('bulk_discounts.quantity_threshold <= ?', quantity)
  #   .order(percentage_discount: :desc)
  #   .first
  # end
end
