class AddUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :user_id, :integer, null: false
  end
end
