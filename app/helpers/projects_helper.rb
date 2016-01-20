module ProjectsHelper
	def body_top_color project
		if project.status == "0. Need to be fixed"
			"panel panel-red"
		elsif project.status == "1. Hold for some reason" 
			"panel panel-gray"
		elsif project.status == "5. In production"
			"panel panel-green"
		else
			"panel panel-blue"
		end
	end
end
