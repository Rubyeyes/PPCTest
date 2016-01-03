class RoleOptionsController < ApplicationController
  def index
    @role_options = RoleOption.all.order(id: :desc).page params[:page]
  end

  def new
    @role_option = RoleOption.new
  end

  def create
    @role_option = RoleOption.new(role_option_params)
    
    if @role_option.save
      redirect_to role_options_url, notice: "Role option was successfully created"
    else
      flash[:alert] = "There was a problem creating role option"
      render :new
    end
  end

  def edit
    @role_option = RoleOption.find(params[:id])
  end

  def update
    @role_option = RoleOption.find(params[:id])
    if @role_option.update(role_option_params)
      redirect_to role_options_url, notice: "Role option was successfully updated"
    else
      flash[:alert] = "There was a problem updating role option"
      render :edit
    end
  end

  def show
  end

  def destroy
    @role_option = RoleOption.find(params[:id])
    @role_option.destroy
    redirect_to :back, notice: "Role option was successfully deleted"
  end

  private

  def role_option_params
    params.require(:role_option).permit(:id, :name)
  end

end
