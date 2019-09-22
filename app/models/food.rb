class Food < ApplicationRecord
  belongs_to :user

  has_many :cart_foods,dependent: :destroy
  has_many :carts, through: :cart_foods

  has_many :order_items
end
