class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.datetime :receive_date
      t.integer :quantity
      t.text :description
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
