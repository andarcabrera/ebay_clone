class AuctionWorker
  include Sidekiq::Worker

  def perform(item_id)
    item = Item.find(item_id)
    item.with_lock do
      if item.available && item.bids.count > 0
        winning_bid = item.bids.find_by(amount: item.highest_bid)
        purchase = Purchase.create(item_id: item.id, purchaser_id: winning_bid.bidder_id)
        item.update_attributes(available: false)
        ItemSoldMailer.notify_seller(purchase, item).deliver_now
        ItemSoldMailer.notify_after_auction(purchase, item).deliver_now
      end
    end
  end
end
