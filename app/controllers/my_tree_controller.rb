class MyTreeController < ApplicationController
  before_action :order_count, only: [:show]
  before_action :recuser_money, only: [:show]

  def show
    @save_orders = Order.all.count #網站總訂單數
  end

  private
  def order_count #計算訂單總數
    giver_orders = current_user.giver_orders.count #計算Giver訂單總數
    rescuer_orders = current_user.rescuer_orders.count #計算Rescuer訂單總數
    @order_count = giver_orders + rescuer_orders
  end

  def recuser_money #計算省下的錢
    rescuer_items = current_user.rescuer_orders.map do |order|
      order.order_items.map do |item| 
        item.food.origin_price - item.food.discount_price
      end
    end
    #把登入者的rescuer_orders一項一項抽出來，分項計算，order_item中每一項食物原價減去折扣價
    @rescuer_money = rescuer_items.flatten.sum 
    #rescuer_items計算結果會是雙重陣列，先抽出來再計算總金額    
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


