require 'faker'
require 'bcrypt'

images = Dir.entries(File.open(File.join(Rails.root, "app/assets/images/sample_images/"))) - [".", ".."]
tag_name_options = ["colorful", "vibrant", "entertaining", "pretty", "sunny", "dry", "active"]

10.times do
  user = User.find_or_create_by(username: Faker::Lorem.word,
                                email: Faker::Internet.email,
                                password_hash: BCrypt::Password.create("1234password"))

  item = user.listings.find_or_create_by(name: Faker::Lorem.word,
                                         description: Faker::Lorem.paragraph,
                                         starting_bid_price: Faker::Number.number(2),
                                         buy_it_now_price: Faker::Number.number(3),
                                         auction_end_time: Faker::Time.forward(2, :morning))

  item.image.store!(File.open(File.join(Rails.root, File.join("app/assets/images/sample_images/", images.sample))))
  item.save

  tag_names = tag_name_options[rand(0..3)..rand(4..6)]
  tag_names.each do |tag_name|
    tag = Tag.find_or_create_by(name: tag_name)
    item.tags << tag
  end
end

