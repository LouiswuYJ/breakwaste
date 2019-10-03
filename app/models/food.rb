class Food < ApplicationRecord
  validates_presence_of :title, :address
  belongs_to :user
  has_many :cart_foods,dependent: :destroy
  has_many :carts, through: :cart_foods

  has_many :order_items, dependent: :delete_all
  has_one_attached :avatar
end
