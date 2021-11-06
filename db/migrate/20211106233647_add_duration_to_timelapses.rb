class AddDurationToTimelapses < ActiveRecord::Migration[6.0]
  def change
    add_column :timelapses, :duration, :integer
  end
end
