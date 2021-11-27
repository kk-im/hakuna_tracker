class AddEmailToProyects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :email, :string
  end
end
