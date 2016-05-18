require 'purchase/presenters/new_purchase_presenter'

class PurchasesController < ApplicationController

  def new
    item = Item.find(params[:id])
    purchase = Purchase.new
    @presenter = NewPurchasePresenter.new(purchase, item)
  end

  def create
    purchase = Purchase.new(purchase_params)
    item = Item.find(purchase.item_id)
    @presenter = NewPurchasePresenter.new(purchase, item)
    if @presenter.purchase.save
      ItemSoldMailer.notify_seller(@presenter).deliver_now
      render :show
    else
      redirect_to "/items/#{@presenter.item_id}/purchases/new"
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:email, :item_id)
  end
end
