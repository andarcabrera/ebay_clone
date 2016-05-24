require 'faker'
require 'bcrypt'
include BCrypt
images = Dir.entries(File.open(File.join(Rails.root, "public/sample_images/"))) - [".", ".."]

10.times do
  user = User.find_or_create_by(username: Faker::Lorem.word,
                                email: Faker::Internet.email,
                                password_hash: Password.create("1234password"))

  item = user.items.find_or_create_by(name: Faker::Lorem.word,
                         description: Faker::Lorem.paragraph,
                         price: Faker::Number.number(2))

  item.image.store!(File.open(File.join(Rails.root, File.join("public/sample_images/", images.sample))))
  item.save
end
