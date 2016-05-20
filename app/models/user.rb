class User < ActiveRecord::Base
  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true
  has_many :items
end
