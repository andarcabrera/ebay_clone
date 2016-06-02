class AuctionWorker
  include Sidekiq::Worker

  def perform(item_id)
    Item.transaction do
      item = Item.lock.find(item_id)
      if item.available && item.bids.count > 0
        winning_bid = item.bids.find { |bid| bid.amount == item.highest_bid }
        purchase = Purchase.create(item_id: item.id, purchaser_id: winning_bid.bidder_id)
        ItemSoldMailer.notify_seller(purchase, item).deliver_now
        ItemSoldMailer.notify_after_auction(purchase, item).deliver_now
      end
    end
  end
end
