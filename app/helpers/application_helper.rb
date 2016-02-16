module ApplicationHelper

	def time_ago time
		"#{time_ago_in_words(time)} ago"
	end

	# Only shows the project belong to current factory
	def project_select current_user
		if current_user.role == "factory"
			Project.where(user_id: current_user.id).order(project_name: :asc).collect {|t| [t.project_name, t.id]}
		elsif current_user.role == "admin" || "user" || "user2"
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

	def smart_form object, controller, &block
		if controller == 'projects'
			
			if object.id.present?
			 	form_for object, url: url_for(controller: controller, action: 'update', id: object.id), class: "form-horizontal", :html => {:multipart => true}, &block
			else
			 	form_for object, class: "form-horizontal", :html => {:multipart => true},  &block
			end
		else
			if object.id.present?
			 	form_for object, url: url_for(controller: controller,action: 'update', id: object.id), &block
			else
			 	form_for object, &block
			end
		end
	end

	
	def smart_unit_cost product
		if product.cost.present?
			if current_user.role == 'factory'
				number_to_currency(product.cost.unitRMB)
			elsif current_user.role == 'admin' || current_user.role == 'user'
				number_to_currency(product.cost.unitUSD)
			end
		end
	end	

	def smart_tooling_fee product
		if product.cost.present?
			if current_user.role == 'factory'
				number_to_currency(product.cost.toolingRMB)
			elsif current_user.role == 'admin' || current_user.role == 'user'
				number_to_currency(product.cost.toolingUSD)
			end
		end
	end
	

	def smart_patent_number patent_project	
		if patent_project.patent.status.to_s == "Patent Pending"
			patent_project.patent.status.to_s 
		else 
			patent_project.patent.patent_number.to_s
		end 
	end

end
