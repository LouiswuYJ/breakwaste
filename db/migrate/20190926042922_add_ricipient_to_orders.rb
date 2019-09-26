class AddRicipientToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :recipient, :string
  end
end
