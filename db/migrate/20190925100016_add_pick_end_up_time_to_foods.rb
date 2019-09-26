class AddPickEndUpTimeToFoods < ActiveRecord::Migration[5.2]
  def change
    add_column :foods, :pickup_time, :datetime
    add_column :foods, :endup_time, :datetime
  end
end
