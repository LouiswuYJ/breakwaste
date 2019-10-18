class Food < ApplicationRecord
  validates_presence_of :address, length: { maximum: 30, too_long: "最多只能輸入30個字" }
  validates :phone, presence: true, numericality: true, length: { maximum: 10, too_long: "最多只能輸入10個字" }
  validates :title, presence: true, length: { maximum: 7, too_long: "最多只能輸入7個字" }
  validates :description, length: { maximum: 100, too_long: "最多只能輸入100個字" }
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :origin_price, numericality: { only_integer: true }, length: { maximum: 7, too_long: "最多只能到7位數" }
  validates :discount_price, numericality: { less_than: :origin_price }, length: { maximum: 7, too_long: "最多只能到7位數" }
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
