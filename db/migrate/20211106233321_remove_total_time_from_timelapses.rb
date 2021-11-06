class RemoveTotalTimeFromTimelapses < ActiveRecord::Migration[6.0]
  def change
    remove_column :timelapses, :total_time, :time
  end
end
