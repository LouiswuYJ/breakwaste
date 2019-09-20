class Food < ApplicationRecord
  belongs_to :user

  has_many :cart_foods
  has_many :carts, through: :cart_foods
end
