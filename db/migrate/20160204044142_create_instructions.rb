class CreateInstructions < ActiveRecord::Migration
  def change
    create_table :instructions do |t|
      t.string :instruction
      t.text :description
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
