module ActiveRecordRepository
  class Item < ActiveRecord::Base
    validates :name, :description, :price, :email,  presence: true
    mount_uploader :image, ImageUploader
  end
end
