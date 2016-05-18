class Item < ActiveRecord::Base
  validates :name, :description, :price, :email,  presence: true
  mount_uploader :image, ImageUploader

  before_create :make_available

  def make_available
    self.available ||= true
  end
end

