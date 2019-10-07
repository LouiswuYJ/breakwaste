class MyTreeController < ApplicationController
  
  def show
    giver_orders = current_user.giver_orders.count
    rescuer_orders = current_user.rescuer_orders.count
    @order_count = giver_orders + rescuer_orders
  end

end


