class PurchasesController < ApplicationController

  def new
    @item = Item.find(params[:id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    item = Item.find(@purchase.item_id)
    if @purchase.save
      ItemSoldMailer.notify_seller(item, @purchase).deliver_now
      render :show
    else
      redirect_to "/items/#{@purchase.item_id}/purchases/new"
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:email, :item_id)
  end
end
