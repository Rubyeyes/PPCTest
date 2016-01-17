class AddUserRefNotifIdTypeToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :user, index: true, foreign_key: true
    add_column :notifications, :notifiable_id, :integer
    add_column :notifications, :notifiable_type, :string
  end
end
