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
  Faker::Number.between(from: 50, to: 500)  
end

def discount_price
  origin_price * 0.4
end

10.times do |i|
  User.create(name: Faker::Name.name, password: 111111, phone: '0923111111', email: "giver#{i+1}@breakwaste.com", address:Faker::Address.street)
end

20.times do |i|
  food = User.find(rand(1..5)).foods.build(title:Faker::Food.title,
                            address:Faker::Address.street,
                            phone:Faker::Food.formats,
                            quantity:Faker::Number.between(from: 1, to: 15),
                            origin_price: origin_price,
                            discount_price: discount_price,
                            pickup_time:Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening),
                            endup_time:Faker::Time.between_dates(from: Date.today, to: Date.today, period: :midnight),
                            description:Faker::Food.tw_description)
  food.avatar.attach(io: File.open("app/assets/images/food_img/food#{rand(1..10)}.jpg"), filename: "food#{rand(1..10)}.jpg")
  byebug
  food.save                          
end

# Food.all.each do |food|
#   food.avatar.attach(io: File.open("app/assets/images/food_img/food#{rand(1..10)}.jpg"), filename: "food#{rand(1..10)}.jpg")
#   food.save
#   # food.avatar.attach(io: URI.open("https://picsum.photos/300/300/?random=#{rand(1..10)}"), filename: 'tree1.png')
# end

#如果seed無法產出，可暫時先把food.rb的第14行 "validates :avatar, attached: true, content_type: [:png, :jpg]" 註解
puts "完成!"

