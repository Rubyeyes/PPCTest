class CurrentUserController < ApplicationController 

  def index
  	@current_user = current_user
    @pos = Po.all.order(date: :desc).limit(2)
    @reports = Report.all.order(created_at: :desc).limit(2)
    @costs = Cost.all.order(created_at: :desc).limit(2)
    @samples = Sample.all.order(created_at: :desc).limit(2)
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
