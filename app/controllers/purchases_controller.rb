class PurchasesController < ApplicationController

  def new
    @item = Item.find(params[:id])
  end

  def create
  end

end
