class RegistrationsController < Devise::RegistrationsController

	def update
	    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
	    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

	    resource_updated = update_resource(resource, account_update_params)
	    yield resource if block_given?
	    if resource_updated
	      if is_flashing_format?
	        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
	          :update_needs_confirmation : :updated
	        set_flash_message :notice, flash_key
	      end
	      sign_in resource_name, resource, bypass: true
	      respond_with resource, location: after_update_path_for(resource)
	    else
	      clean_up_passwords resource
	      respond_with resource
	    end
	end

	protected

	def account_update_params
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fullname, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :fullname, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:fullname, :email, :password, :password_confirmation, :current_password) }
	  devise_parameter_sanitizer.sanitize(:account_update)
	end
end
