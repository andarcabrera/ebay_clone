class AddAuctionEndTime < ActiveRecord::Migration
  def change
    add_column :items, :auction_end_time, :datetime
  end
end
