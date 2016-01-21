class ProjectsController < ApplicationController 

  load_and_authorize_resource

  def index
    @user = current_user
    @filter = Project.text_filter(params[:filter].to_s)
    @search = @filter.text_search(params[:query].to_s)
    @projects = @search.user_filter(@user).text_sort.page params[:page]
    @products = Product.all
    @tasks = Task.all
    @costs = Cost.all.order(crreated_at: :desc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @users = User.notification_recipients(@project, current_user, params[:controller])
    
    if @project.save
      @users.each do |user|
        Notification.create_notification(@project, "create project of", current_user.id, user.id, params[:controller])
      end
      redirect_to projecs_path, notice: "Project was successfully created"
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
    @users = User.notification_recipients(@project, current_user, params[:controller])
    
    if @project.update(project_params)
      @users.each do |user|
        Notification.create_notification(@project, "updated project of", current_user.id, user.id, params[:controller])
      end
      redirect_to controller: 'projects', action: 'show', id: @project.id
      flash[:notice] = "Project was successfully updated"
    else
      flash[:alert] = "There was a problem updating project"
      render :edit
    end
  end

  def show
    @project = Project.find(params[:id])
    @products = Product.all
    @tasks = Task.all.order(created_at: :desc)
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to :back, notice: "Project was successfully deleted"
  end

  private

  def project_params
    params.require(:project).permit(:id, :project_name, :user_id, :description, :image, :remote_image_url, :status, :problem)
  end

end
