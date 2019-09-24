class AddEndupTimeToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :endup_time, :string
  end
end
