class CartFood < ApplicationRecord
  belongs_to :cart
  belongs_to :food
end
