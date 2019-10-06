class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:show, :transaction, :destroy, :payment]
  
  def index
    # @orders = Order.where(user: current_cart)
    #或從使用者角度建立
    # if Order.find_by(user_id: current_user.id).nil?
    #   redirect_to foods_path, notice: '訂單現在是空的喔～'
    # else
    #   if current_user.id == Order.find_by(user_id: current_user.id).user_id
    #       @orders = current_user.rescuer_orders.order(created_at: :asc)
    #   end
    # end
    @rescuer_orders = current_user.rescuer_orders.order(created_at: :asc)
    @giver_orders = current_user.giver_orders.order(created_at: :asc)
  end

  def payment
  end
  
  def create
    giver_id = current_cart.cart_foods.find(params[:order][:cart_food_id]).giver_id
    @cart_foods = current_cart.cart_foods.where(giver_id: giver_id)
    @order = current_user.rescuer_orders.new(order_params)
    @order.giver_id = giver_id
    @cart_foods.each do |food|
      @order.order_items << OrderItem.new(food_id: food.food_id, quantity: food.quantity, giver_id: food.giver_id, rescuer_id: current_user.id)
    byebug
    end
    #把購物車裡的東西拿出來，一條一條塞入order_items 
    if @order.save
      # current_cart.foods.destroy_all #訂單成立後購物車要清空  => 改成付款成立訂單後再刪除，暫時先關掉 
      redirect_to payment_order_path(@order), notice: '訂單已成立' 
    else
      render 'carts/checkout'
    end    
  end

  def show
  end


  def payment
  end

  def destroy
    @order.destroy
    redirect_to orders_path, notice: '訂單已取消' 
  end

  def transaction
    # if @order.may_pay? #may_pay? 是AASM 產生的方法
    #     @order.pay!       #pay! 是AASM 產生的方法 
    # else
    #   redirect_to orders_path, notice: '訂單已完成付款'
    # end  
  end
 
  private
  def find_order
    @order = current_user.rescuer_orders.friendly.find(params[:id]) 
  end
  
  def order_params
    params.require(:order).permit(:recipient, :phone, :note)
  end  
end
