class AddAuctionEndTimeAndCurrentBid < ActiveRecord::Migration
  def change
    add_column :items, :auction_end_time, :datetime
    add_column :items, :current_bid, :decimal, precision: 10, scale: 2
  end
end
