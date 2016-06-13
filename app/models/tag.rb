class Tag < ActiveRecord::Base
  validates :name, presence: true
  has_many :taggings
  has_many :items, through: :taggings
end
