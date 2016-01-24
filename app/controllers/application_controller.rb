class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  before_filter :authenticate_user!
  before_filter :pass_variable

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end
 
	

 def pass_variable
 	@logo = Logo.find_by(name: "NcSTAR Image Logo")
 	@user = current_user
 	@notifications = Notification.where(recipient_id: current_user.id) if current_user.present?
 end

end
