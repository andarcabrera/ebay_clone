class Bid < ActiveRecord::Base
  validates :item_id, :bidder_id, :amount, presence: true
  validate :verify_amount, :verify_availability, :auction_over
  belongs_to :bidder, class_name: "User", foreign_key: :bidder_id
  belongs_to :item

  def verify_amount
    if amount && amount <= item.highest_bid
      errors.add(:amount, "Please bid higher than the current bid.")
    end
  end

  def verify_availability
    if !item.available
      errors.add(:unavailable_item, "The item is no longer available.")
    end
  end

  def auction_over
    if item.auction_end_time <= Time.now
      errors.add(:auction_over, "You can no longer bid on this item. The auction is over.")
    end
  end
end
