require 'faker'

10.times do
  user = User.find_or_create_by(username: Faker::Lorem.word,
                                email: Faker::Internet.email,
                                password: Faker::Lorem.word)

  item = user.items.find_or_create_by(name: Faker::Lorem.word,
                         description: Faker::Lorem.paragraph,
                         price: Faker::Number.number(2))

  item.image.store!(File.open(File.join(Rails.root, File.join("app/assets/images/sample_images/", images.sample))))
  item.save
end
