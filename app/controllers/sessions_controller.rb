class SessionsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # load_and_authorize_resource

  # rescue_from CanCan::AccessDenied do | exception |
  #   redirect_to root_url, alert: exception.message
  # end
end
