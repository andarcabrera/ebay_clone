require 'item_marketplace/presenters/items_index_presenter'
require 'item_marketplace/presenters/new_item_presenter'

class ItemsController < ApplicationController
  def index
    @presenter = ItemsIndexPresenter.new(available_items.limit(100))
  end

  def new
    @presenter = NewItemPresenter.new(Item.new)
  end

  def create
    @presenter = NewItemPresenter.new(Item.new(item_params))
    if @presenter.item.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :email, :image)
  end

  def available_items
    Item.all.where(available: true)
  end
end
