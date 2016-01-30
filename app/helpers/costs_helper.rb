module CostsHelper
	def sortable column, title = nil
		title ||=colunm.titleize
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, costs_path(params.merge(sort: column, direction: direction))
	end

	# Only shows the project belong to current factory
	def project_select current_user
		if current_user.role == "factory"
			Project.where(user_id: current_user.id).order(project_name: :asc).collect {|t| [t.project_name, t.id]}
		elsif current_user.role == "admin" || "user"
			Project.all.order(project_name: :asc).collect {|t| [t.project_name, t.id]}
		end
	end
end
