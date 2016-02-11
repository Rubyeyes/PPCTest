class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic: true
  belongs_to :sender, class_name: 'User', primary_key: "sender_id"
  belongs_to :recipient, class_name: 'User', primary_key: "recipient_id"

  def self.create_notification object, content, sender_id, recipient_id, controller_name, user
    @notification = object.notifications.new
    @notification.content = content
    @notification.sender_id = sender_id
    @notification.recipient_id = recipient_id
    @notification.read = false
    if controller_name == "projects"
    	@notification.item = object.project_name
    elsif controller_name == "po_products"
    	@notification.item = object.product.project.project_name
    else
    	@notification.item = object.project.project_name
    end
		@notification.save
    UserMailer.notification_email(user, @notification).deliver
  end
end
