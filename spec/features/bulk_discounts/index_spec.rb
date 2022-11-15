require 'rails_helper'

RSpec.describe "bulk discount index page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Shawn LLC")
    @merchant_2 = Merchant.create!(name: "Naomi LLC")
    @merchant_3 = Merchant.create!(name: "Kristen LLC")
    @merchant_4 = Merchant.create!(name: "Yuji LLC")
    @merchant_5 = Merchant.create!(name: "Turing LLC")

    @bulk_discount_1 = @merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 10)
    @bulk_discount_2 = @merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 15)
    @bulk_discount_3 = @merchant_2.bulk_discounts.create!(percentage_discount: 15, quantity_threshold: 15)
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"
  end

  it "shows all bulk discounts" do
    expect(page).to have_content("Bulk Discounts")
    within("#bd-#{@bulk_discount_1.id}") do
      expect(page).to have_content("Percentage: #{@bulk_discount_1.percentage_discount}")
      expect(page).to have_content("Bulk: #{@bulk_discount_1.quantity_threshold}")
      expect(page).to_not have_content("Percentage: #{@bulk_discount_3.percentage_discount}")
    end

    within("#bd-#{@bulk_discount_2.id}") do
      expect(page).to have_content("Percentage: #{@bulk_discount_2.percentage_discount}")
      expect(page).to have_content("Bulk: #{@bulk_discount_2.quantity_threshold}")
    end
  end

  it "has links to each show page" do
    click_link "Bulk Discount #{@bulk_discount_1.id}"
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts/#{@bulk_discount_1.id}")
  end

  it "has link to create new bulk discounts" do
    click_link "Create Discount"
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1.id))
  end

  it "has link to delete bulk discount" do
    within("#bd-#{@bulk_discount_1.id}") do
      click_link "Delete Discount #{@bulk_discount_1.id}"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/bulk_discounts")
    end
  end
end
