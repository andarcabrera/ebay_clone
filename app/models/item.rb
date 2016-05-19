class Item < ActiveRecord::Base
  validates :name, :description, :price, :email,  presence: true
  scope :available, -> {  where(available: true) }
  mount_uploader :image, ImageUploader
end

