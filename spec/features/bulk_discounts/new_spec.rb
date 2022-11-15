require 'rails_helper'

RSpec.describe "create new bulk discount" do
  describe ' form to create discount ' do
    before :each do
      @merchant_1 = Merchant.create!(name: "Shawn LLC")
      @merchant_2 = Merchant.create!(name: "Naomi LLC")
      @merchant_3 = Merchant.create!(name: "Kristen LLC")
      @merchant_4 = Merchant.create!(name: "Yuji LLC")
      @merchant_5 = Merchant.create!(name: "Turing LLC")

      @bulk_discount_1 = @merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
      @bulk_discount_2 = @merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
      @bulk_discount_3 = @merchant_2.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)
    end

    it "create new discount" do
      visit new_merchant_bulk_discount_path(@merchant_1.id)
      fill_in("percentage_discount", with: 90)
      fill_in("quantity_threshold", with: 3)
      click_on("Create Discount")
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts")
    end
  end
end
