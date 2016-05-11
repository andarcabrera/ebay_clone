class Item < ActiveRecord::Base
  validates :name, :description, :price, :email,  presence: true
end

