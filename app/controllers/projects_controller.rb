class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order(id: :desc).page params[:page]
  end

  def new
  end

  def create
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    # @project = Project.find(params[:id])
    # if @project.update(project_params)
    #   redirect_to projects_url, notice: "Project was successfully updated"
    # else
    #   flash[:alert] = "There was a problem updating project"
    #   render :new
    # end
  end

  def view
  end

  def destroy
  end

  # private

  # def project_params
  #   params.require(:project).permit(:id, :project_name)
  # end

end
