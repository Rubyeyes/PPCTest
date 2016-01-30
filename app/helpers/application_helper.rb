module ApplicationHelper

	def time_ago time
		"#{time_ago_in_words(time)} ago"
	end

	def smart_navbar_color controller
		if ['home', 'devise/sessions', 'registrations'].include?(controller)
			"navbar-full navbar-inverse navbar-transparent"
		else
			"navbar-full navbar-inverse navbar-normal"
		end
	end

	def smart_navbar_position controller
		if ['home', 'devise/sessions', 'registrations'].include?(controller)
			"navbar-static-top"
		else
			"navbar-fixed-top"
		end
	end

	def smart_container controller
		if ['home', 'devise/sessions', 'registrations'].include?(controller)
			"container-fluid"
		else
			"container"
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
