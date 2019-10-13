class Food < ApplicationRecord
  validates_presence_of :title, :address, :quantity, :phone
  validates :origin_price, numericality: { only_integer: true }
  validates :discount_price, numericality: { less_than: :origin_price }
  validates :pickup_time, :endup_time, presence: true
  validate :pickup_time_after_now

  belongs_to :user
  has_many :cart_foods,dependent: :destroy
  has_many :carts, through: :cart_foods

  has_many :order_items, dependent: :delete_all
  has_one_attached :avatar
  validates :avatar, attached: true, content_type: [:png, :jpg]
  

  def self.search(search)
    if search
      where(['title || description || address LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def pickup_time_after_now
    if pickup_time.present? && pickup_time < Time.now
      errors.add(:pickup_time, "不能回到過去，請重新填寫領取時間！")
    end
  end    
end
