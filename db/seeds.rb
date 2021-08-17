# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Start seeding'.green

Chewy.strategy(:atomic) do
  25.times do
    city = City.new
    city.name = Faker::Address.country
    user = city.users.build
    user.name = Faker::Name.first_name
    user.email = Faker::Internet.email
    city.save!
  end
end

puts 'Finished seeding'.green
