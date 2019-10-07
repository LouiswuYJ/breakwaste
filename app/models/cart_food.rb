class CartFood < ApplicationRecord
  belongs_to :cart
  belongs_to :food

  belongs_to :giver, class_name: 'User', foreign_key: :giver_id    #預設的外部鍵叫做 giver_id

  def total_price
    food = CartFood.find_by(giver_id: giver.ids) 
    price = Food.find(food.food_id).discount_price
    food.quantity * price
  end
end
