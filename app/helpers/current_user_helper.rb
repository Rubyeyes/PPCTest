module CurrentUserHelper
	def sortable column, title = nil
		title ||=colunm.titleize
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, current_user_index_path(params.merge(sort: column, direction: direction))
	end
end
