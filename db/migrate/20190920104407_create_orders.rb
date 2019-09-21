class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :rescuer_name
      t.string :phone
      t.text :note

      t.timestamps
    end
  end
end
