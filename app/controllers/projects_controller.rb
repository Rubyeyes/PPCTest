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
  end

  def view
  end

  def destroy
  end
end
