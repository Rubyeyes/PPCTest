class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :desc).page params[:page]
  end

  def new
  end

  def create
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_admin_index_url, notice: "User was successfully updated"
    else
      flash[:alert] = "There was a problem updating user"
      render :edit
    end
  end

  def show
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :role)
  end

end
