class CartFood < ApplicationRecord
  attr_reader :food_id, :quantity
  belongs_to :cart
  belongs_to :food


  # def initialize(food_id, quantity = 1)
  #   @food_id = food_id
  #   @quantity = quantity
  # end

  # def increment(n = 1)
  #   @quantity += n
  # end

  # def food
  #   Food.find_by(id: food_id)
  # end

  # def total_price
  #   food.price * quantity
  # end
end
