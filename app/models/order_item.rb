class OrderItem < ApplicationRecord
  belongs_to :food
  belongs_to :order
end
