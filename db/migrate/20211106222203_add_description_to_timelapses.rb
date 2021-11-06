class AddDescriptionToTimelapses < ActiveRecord::Migration[6.0]
  def change
    add_column :timelapses, :description, :string
  end
end
