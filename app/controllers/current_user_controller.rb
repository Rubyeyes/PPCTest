class CurrentUserController < ApplicationController
  def index
  	@user = current_user
  end

  def edit
  end

  def update
  end
end
