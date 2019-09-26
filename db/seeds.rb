# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "產出5筆PO文資料"

current_user = User.first

def origin_price
  Faker::Number.between(from: 50, to: 1000)  
end

def discount_price
  origin_price * Faker::Number.between(from: 0.3, to:0.8 ) 
end

def randon_number
  [*1..10].sample
end

5.times do |i|
  current_user.foods.create(title:Faker::Food.title,
                            address:Faker::Address.street,
                            phone:Faker::Food.formats,
                            quantity:Faker::Number.between(from: 1, to: 10),
                            origin_price: origin_price,
                            discount_price: discount_price,
                            pickup_time:Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
                            endup_time:Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
                            # picture:Faker::LoremPixel.image(size: "300x300", is_gray: false, category: 'food', number: randon_number),
                            description:Faker::Food.tw_description)
end
puts "完成!"

