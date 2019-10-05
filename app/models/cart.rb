class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_foods, dependent: :destroy
  has_many :foods, through: :cart_foods

  has_many :givers, through: :cart_foods, source: :user  #變更FK的欄位名稱為user_id
end
