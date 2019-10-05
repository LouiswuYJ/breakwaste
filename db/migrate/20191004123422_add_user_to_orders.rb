class AddUserToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :giver_id, :integer
    add_column :orders, :rescuer_id, :integer
  end
end
