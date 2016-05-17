class Purchase < ActiveRecord::Base
  validates :email, :item_id, presence: true
end

