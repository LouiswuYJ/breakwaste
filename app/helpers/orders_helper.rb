module OrdersHelper
  def find_order_rescuer(order_item)
    Order.find_by(rescuer_id: order_item.rescuer_id)
  end

  def find_giver(giver_id)
    User.find(giver_id)
  end
end
