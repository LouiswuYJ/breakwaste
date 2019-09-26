class OrdersController < ApplicationController
  def create
    @order = current_user.orders.build(order_params)
      current_cart.items.each do |food|
      @order.order_items << OrderItem.new(product: item.product, quantity: item.quantity
    end
    #把購物車裡的東西拿出來，一條一條塞入order_items
    
    if @order.save
      # /orders/2/payment
      current_user.cart.cart_foods.destroy_all, notice: '訂單已成立'#訂單成立後購物車要清空
    else
      render 'carts/checkout'
    end
  end
 
  private
  def order_params
    params.require(:order).permit(:recipient,:phone,:note)
  end

end
