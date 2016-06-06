require 'purchase/presenters/new_purchase_presenter'
require 'purchase/presenters/show_purchase_presenter'

class PurchasesController < ApplicationController

  before_action do
    check_current_user("You need to be logged in to purchase this item")
  end

  def create
    purchase = Purchase.new(purchaser_id: current_user.id, item_id: params[:item_id])
    Item.transaction do
      item = Item.lock.find(params[:item_id])
      if purchase.valid?
        purchase.save
        item.update_attributes(available: false)
        send_email(purchase.id, item.id)
        redirect_to action: "show", item_id: item.id, id: purchase.id
      else
        @presenter = ItemsIndexPresenter.new(Item.available.limit(100))
        render "items/index", status: :unprocessable_entity
      end
    end
  end

  def show
    item = Item.find(params[:item_id])
    purchase = Purchase.find(params[:id])
    @presenter = ShowPurchasePresenter.new(purchase, item)
  end

  private

  def buyer_email
    params[:purchase][:email]
  end

  def send_email(purchase_id, item_id)
    SendPurchaseMail.perform_async(purchase_id, item_id)
  end
end
