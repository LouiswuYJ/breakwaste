class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_foods,dependent: :destroy
  has_many :foods, through: :cart_foods
end
