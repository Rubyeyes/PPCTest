class CreatePatentProjects < ActiveRecord::Migration
  def change
    create_table :patent_projects do |t|
      t.references :patent, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
