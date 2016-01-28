module ApplicationHelper

	def time_ago time
		"#{time_ago_in_words(time)} ago"
	end

	def smart_navbar_color controller
		if controller == 'home' || ('devise/sessions' && action_name == 'new')
			"navbar-full navbar-inverse navbar-transparent"
		else
			"navbar-full navbar-inverse navbar-normal"
		end
	end
	

end
