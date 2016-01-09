class ProjectsController < ApplicationController 

  load_and_authorize_resource

  def index
    @projects = Project.all.order(id: :desc).page params[:page]
    @products = Product.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      redirect_to root_url, notice: "Project was successfully created"
    else
      flash[:alert] = "There was a problem creating project"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to controller: 'home', action: 'show', id: @project.id
      flash[:notice] = "Project was successfully updated"
    else
      flash[:alert] = "There was a problem updating project"
      render :edit
    end
  end

  def show
    @project = Project.find(params[:id])
    @products = Product.all
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to :back, notice: "Project was successfully deleted"
  end

  private

  def project_params
    params.require(:project).permit(:id, :project_name, :user_id, :description)
  end

end
