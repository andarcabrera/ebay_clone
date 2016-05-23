class Purchase < ActiveRecord::Base
  validates :email, :item_id, presence: true
  validate :available_item

  def available_item
    if item_id && !Item.find(item_id).available
      errors.add(:available_item, "this item is no longer available")
    end
  end
end


