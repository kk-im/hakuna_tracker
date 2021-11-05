class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :client
      t.date :deadline
      t.time :expected_time
      t.boolean :completed
      t.boolean :within_deadline
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
