class AddDeadlineRefUserToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :finish, :boolean
    add_column :tasks, :executor_id, :integer
  end
end
