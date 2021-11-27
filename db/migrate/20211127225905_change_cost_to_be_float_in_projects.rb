class ChangeCostToBeFloatInProjects < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :cost, :float
  end
end
