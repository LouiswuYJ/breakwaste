class MyTreeController < ApplicationController
  before_action :order_count, only: [:show]
  # before_action :save_money, only: [:show]
  def show
    rescuer_money = current_user.rescuer_orders.each do |order|
      order.order_items.map do |item|
        item.food.origin_price - item.food.discount_price
      end
    end
  end
  private
  def order_count
    giver_orders = current_user.giver_orders.count #計算Giver訂單總數
    rescuer_orders = current_user.rescuer_orders.count #計算Rescuer訂單總數
    @order_count = giver_orders + rescuer_orders
  end

  # def find_rescuer_orders_items
  #   current_user.rescuer_orders.each do |order|
  #     order.order_items
  #   end
  # end

  # def find_giver_orders_items
  #   current_user.giver_orders.each do |order|
  #     order.order_items 
  #   end
  # end

  # def save_money
  #   giver_money = current_user.giver_orders.order_items.foods.each do |oprice, dprice|
  #     oprice - dprice
  #   end

  #   recuser_money = current_user.rescuer_orders.order_items.foods.each do |oprice, dprice|
  #     oprice - dprice
  #   end
  #   @save_money = giver_money + recuser_money
  # end
end


