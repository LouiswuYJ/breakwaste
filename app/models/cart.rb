class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_foods, dependent: :destroy
  has_many :foods, through: :cart_foods
  # has_many :givers, -> { distinct }, through: :cart_foods, foreign_key: :giver_id, source: 'giver'

  # def total_price
  #   cart_foods.reduce(0) { |sum, item| sum + item.total_price }
  # end
end
