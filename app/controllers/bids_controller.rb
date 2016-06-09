require 'item_marketplace/presenters/item_presenter'
require 'bids/presenters/bid_presenter'

class BidsController < ApplicationController

  before_action do
    check_current_user("You need to be logged in to bid on this item")
  end

  def create
    bid = Bid.new(item_id: bid_params[:item_id], bidder_id: current_user.id, amount: bid_params[:amount])
    item = Item.find(params[:item_id])
    item.with_lock do
      if bid.valid?
        bid.save
        redirect_to action: "show", item_id: bid.item_id, id: bid.id
      else
        @presenter = ItemPresenter.new(item, bid)
        render "items/show", status: :unprocessable_entity
      end
    end
  end

  def show
    bid = Bid.find(params[:id])
    @presenter = BidPresenter.new(bid)
  end

  private

  def bid_params
    params.permit(:amount, :item_id)
  end
end
