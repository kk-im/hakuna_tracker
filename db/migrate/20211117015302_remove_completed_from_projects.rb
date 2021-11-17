class RemoveCompletedFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :completed, :boolean
  end
end
