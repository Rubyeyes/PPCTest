class CurrentUserController < ApplicationController 

  def index
  	@current_user = current_user
    if current_user.role == 'admin'
      @missions = Task.all.where(finish: false).text_sort(params[:sort], params[:direction]).page(params[:page]).per(20) 
    else
      @missions = @current_user.missions.where(finish: false).text_sort(params[:sort], params[:direction]).page(params[:page]).per(20) 
    end
  end

  def edit
  	@current_user = current_user
  end

  def update
  	@current_user = User.find(params[:id])
    if @current_user.update(current_user_params)
      redirect_to current_user_index_url, notice: "Account was successfully updated"
    else
      flash[:alert] = "There was a problem updating account"
      render :edit
    end
  end

  private

  def current_user_params
    params.require(:user).permit(:id, :fullname, :email)
  end

end
