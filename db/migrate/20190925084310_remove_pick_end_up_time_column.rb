class RemovePickEndUpTimeColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :foods, :pickup_time
    remove_column :foods, :endup_time
  end
end
