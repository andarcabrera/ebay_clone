require 'purchase/presenters/new_purchase_presenter'

class PurchasesController < ApplicationController

  def new
    item = find_item(item_id)
    purchase = new_purchase(item_id: item_id)
    @presenter = create_presenter(purchase, item)
  end

  def create
    purchase = new_purchase(purchase_params)
    item = find_item(purchase_params[:item_id])
    @presenter = create_presenter(purchase, item)

    if @presenter.purchase.save
      item.update_attributes(available: false)
      send_email(@presenter)
      render :show
    else
      redirect_to "/items/#{@presenter.item_id}/purchases/new"
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:email, :item_id)
  end

  def create_presenter(purchase, item)
    NewPurchasePresenter.new(purchase, item)
  end

  def new_purchase(purchase_params)
    Purchase.new(purchase_params)
  end

  def find_item(id)
    Item.find(id)
  end

  def item_id
    params[:id]
  end

  def send_email(purchase_details)
    ItemSoldMailer.notify_seller(purchase_details).deliver_now
  end
end
