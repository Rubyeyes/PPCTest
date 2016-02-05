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
 	@logo_white = Logo.find_by(name: "NcSTAR Image Logo")
 	@logo_black = Logo.find_by(name: "NcSTAR Image Logo Black")
 	@user = current_user
 	@notifications = Notification.where(recipient_id: current_user.id) if current_user.present?
 end

 def filter model
 	@data = model.all
 	if params[:controller] == 'projects'
		@data = @data.where("user_id = ?", params[:factory]) if params[:factory].present?
		@data = @data.where(id: params[:project]) if params[:project].present?
		@data = @data.search(params[:query].to_s) if params[:query].present?
		@data = @data.where("user_id = ?", current_user.id) if current_user.role == "factory"
 	elsif params[:controller] == 'pos'
		@data = @data.joins(:projects).where("user_id = ?", params[:factory]) if params[:factory].present?
		@data = @data.joins(:projects).where("project_id = ?", params[:project]) if params[:project].present?
		@data = @data.search(params[:query].to_s) if params[:query].present?
		@data = @data.joins(:projects).where("user_id = ?", current_user.id) if current_user.role == "factory"
 	else
		@data = @data.joins(:project).where("user_id = ?", params[:factory]) if params[:factory].present?
		@data = @data.joins(:project).where("project_id = ?", params[:project]) if params[:project].present?
		@data = @data.search(params[:query].to_s) if params[:query].present?
		@data = @data.joins(:project).where("user_id = ?", current_user.id) if current_user.role == "factory"
	end
 end

end
