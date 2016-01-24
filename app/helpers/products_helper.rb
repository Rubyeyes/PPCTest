module ProductsHelper
	def sortable column, title = nil
		title ||=colunm.titleize
		direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
		link_to title, products_path(params.merge(sort: column, direction: direction))
	end
end
