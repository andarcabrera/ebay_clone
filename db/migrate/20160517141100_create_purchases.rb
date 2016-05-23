class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string   :email, null: false
      t.integer  :item_id, null: false

      t.timestamps
    end
  end
end

