class Item < ActiveRecord::Base
  validates :name, :description, :seller_id, presence: true
  validate :price

  scope :available, -> { where(available: true) }

  belongs_to :seller, class_name: "User", foreign_key: :seller_id
  has_one :purchaser, through: :purchases, source: :purchaser
  has_many :bids

  mount_uploader :image, ImageUploader

  def highest_bid
    bids.maximum(:amount) || starting_bid_price
  end

  def price
    if !buy_it_now_price && !starting_bid_price
      errors.add(:price, "you need to select either a starting bid or a buy it now price")
    end
  end
end
