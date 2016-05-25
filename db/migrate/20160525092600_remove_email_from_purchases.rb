class RemoveEmailFromPurchases < ActiveRecord::Migration
  def change
    remove_column :purchases, :email, :string
  end
end
