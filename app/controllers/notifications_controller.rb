class NotificationsController < ApplicationController
  load_and_authorize_resource
  def index
  	@notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).page params[:page]

  end

  def update
  	@notification = Notification.find(params[:id])
  	@notification.update(read: true)
  	redirect_to notification_path(@notification), method: :get
  end

  def show
  	@notification = Notification.find(params[:id])
  end

  def destroy
  	@nontification = Notification.find(params[:id])
    @nontification.destroy
    redirect_to notifications_path, notice: "Notification was successfully deleted"
  end
end
