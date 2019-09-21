class CartFood < ApplicationRecord
  belongs_to :user
  belongs_to :cart
end
