class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def status_update
    merchant = Merchant.find(params[:merchant_id])
   
    if params[:enable]
      item = Item.find(params[:enable])
      item.enable_status
    else
      item = Item.find(params[:disable])
      item.disable_status
    end

    redirect_to merchant_items_path(merchant)
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])

    if item.update(item_params)
      flash[:notice] = "Successfully Updated #{item.name}"
      redirect_to merchant_item_path(merchant, item)
    else
      flash[:alert] = item.errors.full_messages.to_sentence
      redirect_to edit_merchant_item_path(merchant, item)
    end
  end

private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end