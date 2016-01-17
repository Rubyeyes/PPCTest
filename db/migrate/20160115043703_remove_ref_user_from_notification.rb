class RemoveRefUserFromNotification < ActiveRecord::Migration
  def change
    remove_reference :notifications, :user, index: true, foreign_key: true
  end
end
