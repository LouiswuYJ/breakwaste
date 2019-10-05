class CartFood < ApplicationRecord
  belongs_to :cart
  belongs_to :food

  belongs_to :giver, class_name: 'User'    #預設的外部鍵叫做 giver_id
end
