class Item < ActiveRecord::Base
  validates :name, :description, :seller_id, presence: true
  validate :price, :auction_details, :auction_duration

  scope :available, -> { where(available: true) }

  belongs_to :seller, class_name: "User", foreign_key: :seller_id
  has_many :bids
  has_many :taggings
  has_many :tags, through: :taggings

  mount_uploader :image, ImageUploader

  def highest_bid
    bids.maximum(:amount) || starting_bid_price
  end

  def auctioned?
    auction_end_time && starting_bid_price
  end

  def price
    if !buy_it_now_price && !starting_bid_price
      errors.add(:price, "You need to select either a starting bid or a buy it now price.")
    end
  end

  def auction_details
    if (starting_bid_price && !auction_end_time) || (!starting_bid_price && auction_end_time)
      errors.add(:auction_details, "You must select a starting bid and auction end time.")
    end
  end

  def auction_duration
    if auction_end_time && (auction_end_time - Time.now) <= 3600
      errors.add(:auction_duration, "You cannot schedule an auction to be under an hour.")
    end
  end
end
