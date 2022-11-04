class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
 
  validates :first_name, :last_name, :presence => true
  
  def transaction_count
    self.transactions.count
  end
end
