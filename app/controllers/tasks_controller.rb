class TasksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @project = Project.find(params[:project_id_param])
    @tasks = Task.all.order(date: :desc).page(params[:page]).per(20)
  end

  def new
    @project = Project.find(params[:project_id_param])
    @task = @project.tasks.new()
  end

  def create
    @task = Task.new(task_params)
       
    if @task.save      
      redirect_to controller: 'projects', action: 'show', id: @task.project_id
      flash[:notice] = "Task was successfully created"
    else
      flash[:alert] = "There was a problem creating task"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
    if current_user.role == "factory" && @project.user.fullname != current_user.fullname
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @task = Task.find(params[:id])
    @users = User.notification_recipients(@task, current_user, params[:controller])  
    if params[:finish_value].present?
      @task.update(finish: mission_params[:finish_value])
      @users.each do |user|
        Notification.create_notification(@task, "finish the task of", current_user.id, user.id, params[:controller])
      end
      redirect_to :back
      flash[:notice] = "Good Job"
    elsif @task.update(task_params)
      redirect_to controller: 'projects', action: 'show', id: @task.project_id
      flash[:notice] = "Task was successfully updated"
    else
      flash[:alert] = "There was a problem updating task"
      render :edit
    end
  end

  def show
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to :back, notice: "Task was successfully deleted"
  end

  private

  def task_params
    params.require(:task).permit(:id, :executor, :task, :project_id, :deadline, :executor_id, :finish, :start_date)
  end
  def mission_params
    params.permit(:finish_value)
  end

end
