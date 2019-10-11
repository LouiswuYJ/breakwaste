# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "產出10筆PO文資料"

# current_user = User.create(name: Faker::Name.name, password: '111111', phone: '0923111111', email: 'example@gmail.com', role: 'giver')
def origin_price
  Faker::Number.between(from: 50, to: 1000)  
end

def discount_price
  origin_price * 0.6
end

10.times do |i|
  User.create(name: Faker::Name.name, password: 111111, phone: '0923111111', email: "giver#{i+1}@breakwaste", address:Faker::Address.street)
end

50.times do |i|
  User.find(rand(1..5)).foods.create(title:Faker::Food.title,
                            address:Faker::Address.street,
                            phone:Faker::Food.formats,
                            quantity:Faker::Number.between(from: 1, to: 10),
                            origin_price: origin_price,
                            discount_price: discount_price,
                            pickup_time:Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
                            endup_time:Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :all),
                            description:Faker::Food.tw_description)
end

Food.all.each do |food|
  food.avatar.attach(io: File.open("app/assets/images/trees/tree#{rand(1..5)}.png"), filename: 'tree1.png')
    # food.avatar.attach(io: URI.open("https://picsum.photos/300/300/?random=#{rand(1..10)}"), filename: 'tree1.png')
end


puts "完成!"

