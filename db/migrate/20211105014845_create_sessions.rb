class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.time :total_time
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
