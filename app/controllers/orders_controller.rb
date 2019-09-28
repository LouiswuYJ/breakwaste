class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # @orders = Order.where(user: current_cart)
    #或從使用者角度建立
    @orders = current_user.orders.order(created_at: :desc)
  end
  
  def create
    @order = current_user.orders.new(order_params)
    current_cart.foods.each do |food|
      @order.order_items << OrderItem.new(food_id: food.id, quantity: food.quantity)
    end
    #把購物車裡的東西拿出來，一條一條塞入order_items 
    
    if @order.save
      current_cart.foods.destroy #訂單成立後購物車要清空 
      redirect_to payment_order_path(@order), notice: '訂單已成立'
    else
      render 'carts/checkout'
    end
  end

  def payment
    @order = current_user.orders.find(params[:id])
  end
 
  private
  def order_params
    params.require(:order).permit(:recipient, :phone, :note)
  end

end
