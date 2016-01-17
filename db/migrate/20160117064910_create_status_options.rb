class CreateStatusOptions < ActiveRecord::Migration
  def change
    create_table :status_options do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
