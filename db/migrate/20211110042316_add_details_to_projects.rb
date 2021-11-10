class AddDetailsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :rate, :integer
    add_column :projects, :cost, :integer
  end
end
