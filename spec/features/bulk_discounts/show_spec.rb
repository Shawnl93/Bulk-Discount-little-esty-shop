require 'rails_helper'

RSpec.describe "bulk discount show page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")

    @bulk_discount_1 = @merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
    @bulk_discount_2 = @merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
    @bulk_discount_3 = @merchant_2.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)
    visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@bulk_discount_1.id}"
  end

  it "See bulk discount's QT and PD" do
    expect(page).to have_content("Bulk Discount Show Page")
    expect(page).to have_content("Percentage: #{@bulk_discount_1.percentage_discount}")
    expect(page).to have_content("Quantity: #{@bulk_discount_1.quantity_threshold}")
  end

end
