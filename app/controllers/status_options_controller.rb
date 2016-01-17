class StatusOptionsController < ApplicationController
  def index
    @status_options = StatusOption.all.order(id: :desc).page params[:page]
  end

  def new
    @status_option = StatusOption.new
  end

  def create
    @status_option = StatusOption.new(status_option_params)
    
    if @status_option.save
      redirect_to status_options_url, notice: "Role option was successfully created"
    else
      flash[:alert] = "There was a problem creating role option"
      render :new
    end
  end

  def edit
    @status_option = StatusOption.find(params[:id])
  end

  def update
    @status_option = StatusOption.find(params[:id])
    if @status_option.update(status_option_params)
      redirect_to status_options_url, notice: "Role option was successfully updated"
    else
      flash[:alert] = "There was a problem updating role option"
      render :edit
    end
  end

  def show
  end

  def destroy
    @status_option = StatusOption.find(params[:id])
    @status_option.destroy
    redirect_to :back, notice: "Role option was successfully deleted"
  end

  private

  def status_option_params
    params.require(:status_option).permit(:id, :name)
  end
end
