class Item < ActiveRecord::Base
  validates :name, :description, :price, :user_id,  presence: true
  scope :available, -> {  where(available: true) }
  belongs_to :user
  mount_uploader :image, ImageUploader
end

