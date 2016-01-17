class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :username
      t.text :content
      t.string :type
      t.string :item

      t.timestamps null: false
    end
  end
end
