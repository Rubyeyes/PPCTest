class AddReminderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :reminder, :text
  end
end
