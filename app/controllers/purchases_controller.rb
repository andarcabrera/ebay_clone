require 'purchase/presenters/new_purchase_presenter'

class PurchasesController < ApplicationController

  def new
    item = find_item(item_id)
    purchase = new_purchase(item_id: item_id)
    @presenter = create_presenter(purchase, item)
  end

  def create
    purchase = new_purchase(email: buyer_email, item_id: item_id)
    item = find_item(item_id)
    @presenter = create_presenter(purchase, item)

    if purchase.save
      item.update_attributes(available: false)
      send_email(purchase, item)
      render :show
    else
      redirect_to "/items/#{item_id}/purchases/new"
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:email)
  end

  def buyer_email
    purchase_params[:email]
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

  def send_email(purchase, item)
    ItemSoldMailer.notify_seller(purchase, item).deliver_later
  end
end
