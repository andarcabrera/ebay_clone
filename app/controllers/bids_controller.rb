class BidsController < ApplicationController

  before_action do
    check_current_user("You need to be logged in to bid on this item")
  end

  def create
    bid = Bid.new(item_id: params[:item_id], bidder_id: current_user.id, amount: params[:bid][:amount])
    Item.transaction do
      item = Item.lock.find(params[:item_id])
      if bid.valid?
        bid.save
        item.update_attributes(available: false, current_bid: bid.amount)
        redirect_to action: "show", item_id: bid.item_id, id: bid.id
      else
        render "items/index", status: :unprocessable_entity
      end
    end
  end
end
