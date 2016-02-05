module ApplicationHelper

	def time_ago time
		"#{time_ago_in_words(time)} ago"
	end

	# Only shows the project belong to current factory
	def project_select current_user
		if current_user.role == "factory"
			Project.where(user_id: current_user.id).order(project_name: :asc).collect {|t| [t.project_name, t.id]}
		elsif current_user.role == "admin" || "user"
			Project.all.order(project_name: :asc).collect {|t| [t.project_name, t.id]}
		end
	end

	def smart_navbar_color controller
		if ['home', 'devise/sessions', 'registrations'].include?(controller)
			if action_name == "edit"
				"navbar-full navbar-inverse"	
			else
				"navbar-full navbar-default navbar-transparent"
			end
		elsif ['show', 'new', 'edit'].include?(action_name)
			"navbar-full navbar-inverse"	
		else
			"navbar-full navbar-default navbar-normal"
		end
	end

	def smart_logo_color controller
		if ['home', 'devise/sessions', 'registrations'].include?(controller) || ['show', 'new', 'edit'].include?(action_name)
			link_to image_tag(@logo_white.image.url(:detail).to_s, class: "logo"), home_index_path, class: "navbar-brand" if @logo_white.present?
		else
			link_to image_tag(@logo_black.image.url(:detail).to_s, class: "logo"), home_index_path, class: "navbar-brand" if @logo_black.present?
		end
	end
	
	def login_link_select
		if params[:controller] == 'devise/sessions' 
			'#'
		else
			new_user_session_path
		end
	end

end
