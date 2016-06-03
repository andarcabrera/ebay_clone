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
      if auctioned?(item)
        AuctionWorker.perform_in(auction_duration(item).seconds, item.id)
      end
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
    params.require(:item).permit(:name, :description, :buy_it_now_price, :starting_bid_price, :auction_end_time, :image)
  end

  def auction_duration(item)
    item.auction_end_time - Time.now.utc
  end

  def auctioned?(item)
    item.auction_end_time && item.starting_bid_price
  end
end
