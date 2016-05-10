class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    @item = Item.new
    render "new"
  end

end
