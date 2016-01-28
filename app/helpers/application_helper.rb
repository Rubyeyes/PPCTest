module ApplicationHelper

	def time_ago time
		"#{time_ago_in_words(time)} ago"
	end

	def smart_navbar_color controller
		if controller == 'home' || (controller == 'devise/sessions' && action_name == 'new')
			"navbar-full navbar-inverse navbar-transparent"
		else
			"navbar-full navbar-inverse navbar-normal"
		end
	end

	def smart_navbar_position controller
		if controller == 'home' || (controller == 'devise/sessions' && action_name == 'new')
			"navbar-static-top"
		else
			"navbar-fixed-top"
		end
	end

	def smart_container controller
		if controller == 'home' || (controller == 'devise/sessions' && action_name == 'new')
			"container-fluid"
		else
			"container"
		end
	end
	

end
