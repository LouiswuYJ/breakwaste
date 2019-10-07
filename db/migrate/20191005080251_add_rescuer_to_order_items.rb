class AddRescuerToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :giver_id, :integer
    add_column :order_items, :rescuer_id, :integer
  end
end
