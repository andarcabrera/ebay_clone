class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :item_id, null: false
      t.integer :bidder_id, null: false
      t.decimal :amount, null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
