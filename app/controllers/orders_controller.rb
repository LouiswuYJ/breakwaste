class OrdersController < ApplicationController
  def create
    @order = current_user.orders.new(order_params)
    current_cart.foods.each do |food|
      @order.order_items << OrderItem.new(food_id: food.id, quantity: food.quantity)
    end
    #把購物車裡的東西拿出來，一條一條塞入order_items 
    
    if @order.save
      current_user.cart.cart_foods.destroy #訂單成立後購物車要清空 
      redirect_to payment_order_path(@order), notice: '訂單已成立'
    else
      render 'carts/checkout'
    end
  end

  def payment
  
  end
 
  private
  def order_params
    params.require(:order).permit(:recipient, :phone, :note)
  end

end
