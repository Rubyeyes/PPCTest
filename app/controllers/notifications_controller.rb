class NotificationsController < ApplicationController
  def index
  	@notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).page params[:page]
  end

  def destroy
  	@nontification = Notification.find(params[:id])
    @nontification.destroy
    redirect_to :back, notice: "Notification was successfully deleted"
  end
end
