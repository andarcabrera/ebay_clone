class AddIndexToPurchases < ActiveRecord::Migration
  def change
   add_index :purchases, [:email, :item_id], unique: true
  end
end

