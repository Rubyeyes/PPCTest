class ProjectsController < ApplicationController 

  load_and_authorize_resource

  class Forbidden < StandardError; end

  def index
    @user = current_user
    # advance search filter
    filter(Project)
    if params[:stage].present?
      @projects_all = @data.text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_all'
      @projects_0 = @data.where(status: "0. Need to be fixed").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_0'
      @projects_1 = @data.where(status: "1. Hold for some reason").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_1'
      @projects_2 = @data.where(status: "2. Concept design").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_2'
      @projects_3 = @data.where(status: "3. Received prototypes or samples").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_3'
      @projects_4 = @data.where(status: "4. Design package and start producing").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_4'
      @projects_5 = @data.where(status: "5. In production").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_5'
      @projects_6 = @data.where(status: "6. Droped").text_sort.page(params[:page]).per(9) if params[:stage] == 'stage_6'
    else 
      @projects_all = @data.text_sort.page(params[:page]).per(9)
    end
    @products = Product.all.order(item_number: :asc)
    @tasks = Task.all.order(deadline: :desc)
    @costs = Cost.all.order(date: :desc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    # @users = User.notification_recipients(@project, current_user, params[:controller])
    
    if @project.save
      # @users.each do |user|
      #   Notification.create_notification(@project, "create project of", current_user.id, user.id, params[:controller])
      # end
      redirect_to projects_path, notice: "Project was successfully created"
    else
      flash[:alert] = "There was a problem creating project"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @products = Product.all
    @tasks = Task.all.order(created_at: :desc)
    if current_user.role == "factory" && @project.user.fullname != current_user.fullname
      # redirect_to root_path
      # flash[:alert] = "You have no authorization"
      raise Forbidden, "You have no authorization to visit this page" 
    end

  end

  def update
    @project = Project.find(params[:id])
    # @users = User.notification_recipients(@project, current_user, params[:controller])
    
    if @project.update(project_params)
      # @users.each do |user|
      #   Notification.create_notification(@project, "updated project of", current_user.id, user.id, params[:controller])
      # end
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
    if current_user.role == "factory" && @project.user.fullname != current_user.fullname
      # redirect_to root_path
      # flash[:alert] = "You have no authorization"
      raise Forbidden, "You have no authorization to visit this page" 
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted"
  end

  
  private

  def project_params
    params.require(:project).permit(:id, :project_name, :user_id, :description, :image, :remote_image_url, :status, :problem, :patent_number)
  end

end
