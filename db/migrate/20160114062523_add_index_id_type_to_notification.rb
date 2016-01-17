class AddIndexIdTypeToNotification < ActiveRecord::Migration
  def change
    add_index :notifications, [:notifiable_id, :notifiable_type]
  end
end
