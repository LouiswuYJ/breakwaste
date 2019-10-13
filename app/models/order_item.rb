class OrderItem < ApplicationRecord
  belongs_to :food 
  belongs_to :order

  def total_price
    order_item_food = OrderItem.find_by(food_id: food.id)
    food.discount_price * order_item_food.quantity
  end
end
