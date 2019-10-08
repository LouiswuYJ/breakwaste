class CartFood < ApplicationRecord
  belongs_to :cart
  belongs_to :food

  belongs_to :giver, class_name: 'User', foreign_key: :giver_id    #預設的外部鍵叫做 giver_id
  
  
  def total_price
    cart_foods = quantity * food.discount_price
  end
end
