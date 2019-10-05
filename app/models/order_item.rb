class OrderItem < ApplicationRecord
  belongs_to :food 
  belongs_to :order

  def total_price
    current_cart_food = CartFood.find_by(food_id: food.id)
    food.discount_price * current_cart_food.quantity
  end
end
