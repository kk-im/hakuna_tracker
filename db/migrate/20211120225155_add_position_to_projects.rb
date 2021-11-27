class AddPositionToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :position, :integer
  end
end
