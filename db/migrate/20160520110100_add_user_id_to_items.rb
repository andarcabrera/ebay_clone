class AddUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :seller_id, :integer
  end
end
