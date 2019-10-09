class Food < ApplicationRecord
  validates_presence_of :title, :address, :pickup_time, :endup_time, :quantity, :phone
  validates :origin_price, numericality: { only_integer: true }
  validates :discount_price, numericality: { less_than: :origin_price }

  belongs_to :user
  has_many :cart_foods,dependent: :destroy
  has_many :carts, through: :cart_foods

  has_many :order_items, dependent: :delete_all
  has_one_attached :avatar

  def self.search(search)
    if search
      where(['title || description || address LIKE ?', "%#{search}%"])
    else
      all
    end
  end
end
