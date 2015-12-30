class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :executor
      t.text :task

      t.timestamps null: false
    end
  end
end
