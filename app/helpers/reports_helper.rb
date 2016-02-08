module ReportsHelper
	def sortable column, title = nil
		title ||=colunm.titleize
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, reports_path(params.merge(sort: column, direction: direction))
	end

end
