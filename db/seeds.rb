require 'faker'
require 'item_marketplace/active_record_repository/item'

10.times do
 ActiveRecordRepository::Item.find_or_create_by(name: Faker::Lorem.word,
                                                description: Faker::Lorem.paragraph,
                                                price: Faker::Number.number(2),
                                                email: Faker::Internet.email,
                                                image: Faker::Avatar.image)
end

 ActiveRecordRepository::Item.find_or_create_by(name: "computer",
                                                description: "gray",
                                                price: 15,
                                                email: Faker::Internet.email,
                                                image: Faker::Avatar.image)
