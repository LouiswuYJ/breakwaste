class Order < ApplicationRecord
  extend FriendlyId
  friendly_id :order_generator, use: :slugged
  
  has_many :order_items, dependent: :delete_all
  # validates_presence_of :recipient, :phone
  validates :phone, presence: true, numericality: true, length: { maximum: 10, too_long: "最多只能輸入10個字" }
  validates :recipient, presence: true, length: { maximum: 7, too_long: "最多只能輸入7個字" }
  validates :note, length: { maximum: 30, too_long: "最多只能輸入30個字" }

  belongs_to :giver, class_name: 'User', foreign_key: :giver_id 
  belongs_to :rescuer, class_name: 'User', foreign_key: :rescuer_id 
   


  def total_price
    order_items.reduce(0) { |sum, item| sum + item.total_price }
  end

  delegate :email, to: :user

  include AASM
  
  aasm(column: 'status', no_direct_assignment: true) do 
    state :pending, initial: true
    state :paid, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :cancel do
      transitions from: :pending, to: :cancelled
    end

  end

  private
  def order_generator
    if persisted?
      year = created_at.year
      month = created_at.month
      day = created_at.day
    else
      year = Time.now.year
      month = Time.now.month
      day = Time.now.day
    end
    serial = [*'A'..'Z', *0..9].sample(8).join
    "%0d%02d%02d-%s" % [year, month, day, serial]
  end
end
