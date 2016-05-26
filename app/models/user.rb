require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt

  validates :username, :email, :password_hash, presence: true
  validates :email, uniqueness: true

  has_many :listings, class_name: "Item", foreign_key: :seller_id
  has_many :purchases, class_name: "Purchase", foreign_key: :purchaser_id

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(session_params)
    user = User.find_by(email: session_params[:email])
    if user && user.password == session_params[:password]
      user
    end
  end
end
