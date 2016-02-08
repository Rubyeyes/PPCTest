class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
  before_filter :authenticate_user!
  before_filter :pass_variable
  before_filter :set_locale

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  private

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

	 def set_locale
	 	if current_user && params[:locale].present?
	 		current_user.locale = params[:locale]
	 		I18n.locale = current_user.locale.to_sym
	 	else
	 		I18n.locale = I18n.locale
	 	end
	 end

	 def default_url_option(option = {})
	 	{locale: I18n.locale}
	 end

end
