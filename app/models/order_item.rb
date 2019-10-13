class OrderItem < ApplicationRecord
  belongs_to :food 
  belongs_to :order

  def total_price
    order_item_food = OrderItem.find_by(order_id: order.id)
    food.discount_price * order_item_food.quantity
  end
end
