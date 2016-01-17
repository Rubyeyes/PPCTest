class LogosController < ApplicationController
  def index
    @logos = Logo.all.order(id: :desc).page params[:page]
  end

  def new
    @logo = Logo.new
  end

  def create
    @logo = Logo.new(logo_params)
    
    if @logo.save
      redirect_to logos_url, notice: "Role option was successfully created"
    else
      flash[:alert] = "There was a problem creating role option"
      render :new
    end
  end

  def edit
    @logo = Logo.find(params[:id])
  end

  def update
    @logo = Logo.find(params[:id])
    if @logo.update(logo_params)
      redirect_to logos_url, notice: "Role option was successfully updated"
    else
      flash[:alert] = "There was a problem updating role option"
      render :edit
    end
  end

  def show
  end

  def destroy
    @logo = Logo.find(params[:id])
    @logo.destroy
    redirect_to :back, notice: "Role option was successfully deleted"
  end

  def logo_params
    params.require(:logo).permit(:id, :name, :image, :remote_image_url)
  end
end
