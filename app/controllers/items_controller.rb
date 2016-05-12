class ItemsController < ApplicationController
  def index
    @items = RepositoryContainer.get_repo(:item).all
  end

  def new
    @item = RepositoryContainer.get_repo(:item)
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
    params.require(:item).permit(:name, :description, :price, :email, :image)
  end
end
