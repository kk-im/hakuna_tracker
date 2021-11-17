class AddCompletedToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :completed, :boolean, default: false
  end
end
