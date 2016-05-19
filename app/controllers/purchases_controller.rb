require 'purchase/presenters/new_purchase_presenter'
require 'purchase/presenters/show_purchase_presenter'

class PurchasesController < ApplicationController

  def new
    item = Item.find(params[:id])
    purchase = Purchase.new
    @presenter = create_presenter(purchase, item)
  end

  def create
    purchase = new_purchase(email: buyer_email, item_id: item_id)
    Item.transaction do
      item = Item.lock.find(item_id)
      @presenter = create_presenter(purchase, item)

      if purchase.save
        item.update_attributes(available: false)
        send_email(purchase, item)
        redirect_to action: "show", item_id: item.id, id: purchase.id
      else
        render :new
      end
    end
  end

  def show
    item = Item.find(params[:item_id])
    purchase = Purchase.find(params[:id])
    @presenter = ShowPurchasePresenter.new(purchase, item)
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

  def item_id
    params[:id]
  end

  def send_email(purchase, item)
    #SendPurchaseMail.perform_later(purchase, item)
    ItemSoldMailer.notify_seller(purchase, item).deliver_later
  end
end
