require 'item_marketplace/presenters/items_index_presenter'
require 'item_marketplace/presenters/new_item_presenter'

class ItemsController < ApplicationController
  def index
    items = RepositoryContainer.get_repo(:item).all
    @presenter = ItemsIndexPresenter.new(items)
  end

  def new
    item = RepositoryContainer.get_repo(:item)
    @presenter = NewItemPresenter.new(item)
  end

  def create
    repo = RepositoryContainer.get_repo(:item)
    item = repo.new_item(item_params)
    if repo.save(item)
      redirect_to :root
    else
      render :new
    end
  end

  def item_params
    params[:item].permit(:name, :description, :price, :email, :image, :image_cache)
  end
end
