class Tagging < ActiveRecord::Base
  validates :item_id, :tag_id, presence: true
  belongs_to :item
  belongs_to :tag
end
