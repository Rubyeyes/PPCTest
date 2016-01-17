class AddReadSenderReceiverToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :read, :boolean
    add_column :notifications, :sender_id, :integer
    add_column :notifications, :recipient_id, :integer
  end
end
