require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt

  validates :username, :email, :password_hash, presence: true
  validates :email, uniqueness: true

  has_many :listings, class_name: "Item", foreign_key: :seller_id
  has_many :bids, foreign_key: :bidder_id

  def self.authenticate(credentials)
    user = User.find_by(email: credentials[:email])
    if user && user.password == credentials[:password]
      user
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
