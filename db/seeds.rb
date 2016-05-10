# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

10.times do
  Item.find_or_create_by(name: Faker::Lorem.word, description: Faker::Lorem.paragraph, price: Faker::Number.number(2), email: Faker::Internet.email)
end
