class RenameSessionsToTimelapses < ActiveRecord::Migration[6.0]
  def change
    rename_table :sessions, :timelapses
  end
end
