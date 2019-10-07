class MyTreeController < ApplicationController
  before_action :order_count, only: [:show]
  # before_action :save_money, only: [:show]
  def show
    
  end
  private
  def order_count
    giver_orders = current_user.giver_orders.count #計算Giver訂單總數
    rescuer_orders = current_user.rescuer_orders.count #計算Rescuer訂單總數
    @order_count = giver_orders + rescuer_orders
  end

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


