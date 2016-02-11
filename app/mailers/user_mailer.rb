class UserMailer < ApplicationMailer
	default from: 'ncstardashboard@ncstar.com'

  def notification_email(user, notification)
    @user = user
    @notification = notification

    mail to: user.email, subject: "New Notification"
  end
end
