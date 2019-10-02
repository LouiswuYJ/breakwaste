class OrderItem < ApplicationRecord
  belongs_to :food 
  belongs_to :order

  def total_price
    food.discount_price * quantity
  end
end
