class Purchase < ActiveRecord::Base
  validates :item_id, :purchaser_id, presence: true
  validate :available_item
  belongs_to :purchaser, class_name: "User", foreign_key: :purchaser_id
  belongs_to :item
  has_one :seller, through: :item, source: :seller

  belongs_to :purchaser, class_name: "User", foreign_key: :purchaser_id
  belongs_to :item
  has_one :seller, through: :item, source: :seller

  def available_item
    if item_id && !Item.find(item_id).available
      errors.add(:available_item, "This item is no longer available.")
    end
  end
end
