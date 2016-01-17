class RemoveUsernameTypeFromNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :username, :string
    remove_column :notifications, :type, :string
  end
end
