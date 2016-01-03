class CreateRoleOptions < ActiveRecord::Migration
  def change
    create_table :role_options do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
