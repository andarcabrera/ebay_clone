class AddNotNullConstraintToItemsAndPurchases < ActiveRecord::Migration
  def change
    change_column :purchases, :purchaser_id, :integer, null: false
    change_column :items, :seller_id, :integer, null: false
  end
end
