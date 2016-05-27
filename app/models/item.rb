class Item < ActiveRecord::Base
  validates :name, :description, :price, :seller_id, presence: true

  scope :available, -> { where(available: true) }

  belongs_to :seller, class_name: "User", foreign_key: :seller_id
  has_one :purchaser, through: :purchases, source: :purchaser

  mount_uploader :image, ImageUploader
end
