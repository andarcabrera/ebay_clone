class ChangePriceToBuyItNowPrice < ActiveRecord::Migration
  def change
    change_column :items, :price, :int, null: true
    rename_column :items, :price, :buy_it_now_price
  end
end
