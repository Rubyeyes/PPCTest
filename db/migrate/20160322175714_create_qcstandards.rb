class CreateQcstandards < ActiveRecord::Migration
  def change
    create_table :qcstandards do |t|
      t.string :file
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
