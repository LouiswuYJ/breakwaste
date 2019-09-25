# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "產出10筆PO文資料"

current_user = User.first

5.times do |i|
  current_user.foods.create(title:Faker::Food.dish,
                            address:Faker::Address.full_address,
                            phone:Faker::PhoneNumber.cell_phone,
                            quantity:Faker::Number.between(from: 1, to: 10),
                            origin_price:Faker::Number.between(from: 10, to: 500),
                            discount_price:Faker::Number.between(from: 0.1, to: 0.9),
                            pickup_time:Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
                            endup_time:Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
                            # picture:Faker::LoremPixel.image(size: "200x200", is_gray: false, category: 'food'),
                            description:Faker::Food.description)
end
puts "完成!"

