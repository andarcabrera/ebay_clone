require 'item_marketplace/presenters/items_index_presenter'
require 'item_marketplace/presenters/new_item_presenter'

class ItemsController < ApplicationController

  before_action :check_current_user, only: [:new, :create]

  def check_current_user
    if !current_user
      flash[:notice] = "You need to be logged in to add an item"
      render :new
    end
  end

  def index
    @presenter = ItemsIndexPresenter.new(Item.available.limit(100))
  end

  def new
    @presenter = NewItemPresenter.new(Item.new)
  end

  def create
    @presenter = NewItemPresenter.new(current_user.listings.new(item_params))
    if @presenter.item.save
      redirect_to items_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image)
  end
end
