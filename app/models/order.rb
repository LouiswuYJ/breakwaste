class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
#   validates :phone, :address, presence: true
   
#   def total_price
#     order_items.reduce(0) { |sum, item| sum + item.total_price }
#   end

#   delegate :email, to: :user

#   include AASM

#   aasm(column: 'status', no_direct_assignment: true) do 
#     state :pending, initial: true
#     state :paid, :shipping, :delivered, :returned, :refunded

#     event :pay do
#       transitions from: :pending, to: :paid
#     end

#     event :cancel do
#       transitions from: :pending, to: :cancelled
#     end

#     event :deliver do
#       transitions from: :paid, to: :delivered
#     end

#     event :refund do
#       transitions from: [:delivered, :paid], to: :refunded
#     end
#   end

#   private
#   def order_generator
#     if persisted?
#       year = created_at.year
#       month = created_at.month
#       day = created_at.day
#     else
#       year = Time.now.year
#       month = Time.now.month
#       day = Time.now.day
#     end
#     serial = [*'A'..'Z', *0..9].sample(8).join

#     "%0d%02d%02d-%s" % [year, month, day, serial]
#   end
# end
