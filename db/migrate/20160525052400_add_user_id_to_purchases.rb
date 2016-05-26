class AddUserIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :purchaser_id, :integer
  end
end
