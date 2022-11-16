class BulkDiscountsController < ApplicationController
before_action :holidays_info, only: [:index]

  def index
    @bulk_discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def holidays_info
    @holidays = HolidaySearch.new.holiday_info
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if @bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to new_merchant_bulk_discount_path(@merchant)
      flash[:alert] = @bulk_discount.errors.full_messages
    end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    @bulk_discount.update(bulk_discount_params)
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts/#{@bulk_discount.id}"
  end

private
  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end
