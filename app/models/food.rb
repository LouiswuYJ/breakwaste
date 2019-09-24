class Food < ApplicationRecord
  validates_presence_of :title, :address
  belongs_to :user

    # t.string "title"
    # t.text "address"
    # t.string "phone"
    # t.integer "quantity"
    # t.integer "origin_price"
    # t.integer "discount_price"
    # t.string "pickup_time"
    # t.string "picture"
    # t.text "description"


  has_many :cart_foods,dependent: :destroy
  has_many :carts, through: :cart_foods

  has_many :order_items
end
