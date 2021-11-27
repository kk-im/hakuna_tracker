class ChangeDurationToBeFloatInTimelapses < ActiveRecord::Migration[6.0]
  def change
    change_column :timelapses, :duration, :float
  end
end
