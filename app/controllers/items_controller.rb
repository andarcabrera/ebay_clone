require 'item_marketplace/presenters/items_index_presenter'
require 'item_marketplace/presenters/new_item_presenter'
require 'item_marketplace/presenters/item_presenter'

class ItemsController < ApplicationController

  before_action only: [:new, :create] do
    check_current_user("You need to be logged in to add an item")
  end

  def index
    @presenter = ItemsIndexPresenter.new(Item.available.limit(100))
  end

  def new
    @presenter = NewItemPresenter.new(Item.new)
  end

  def create
    item = Item.new(item_params)
    item.seller_id = current_user.id
    if item.valid?
      item.save
      redirect_to items_path
    else
      @presenter = NewItemPresenter.new(item)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    item = Item.find(params[:id])
    @presenter = ItemPresenter.new(item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :buy_it_now_price, :image)
  end
end
