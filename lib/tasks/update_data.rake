task update_data: :environment do
  items = Item.all
  puts "Going to update #{items.count} items"

  ActiveRecord::Base.transaction do
    items.each do |item|
      email = item.email
      seller = User.find_or_create_by(username: email, email: email, password_hash: email)
      item.seller_id = seller.id
      item.save
    end
  end

  purchases = Purchase.all
  puts "Going to update #{purchases.count} purchases"

  ActiveRecord::Base.transaction do
    purchases.each do |purchase|
      email = purchase.email
      purchaser = find_or_create_by(username: email, email: email, password_hash: email)
      purchase.purchaser_id = purchaser.id
      purchase.save
    end
  end
end
