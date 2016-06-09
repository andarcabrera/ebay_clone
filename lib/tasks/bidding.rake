task update_data: :environment do
  items_count = Item.count
  puts "Going to update #{items_count} items"

  ActiveRecord::Base.transaction do
    Item.find_each do |item|
      email = item.email
      seller = User.find_or_create_by(username: email, email: email, password_hash: email)
      item.seller_id = seller.id
      item.save
    end
  end

  purchases_count = Purchase.count
  puts "Going to update #{purchases_count} purchases"

  ActiveRecord::Base.transaction do
    Purchase.find_each do |purchase|
      email = purchase.email
      purchaser = User.find_or_create_by(username: email, email: email, password_hash: email)
      purchase.purchaser_id = purchaser.id
      purchase.save
    end
  end
end
