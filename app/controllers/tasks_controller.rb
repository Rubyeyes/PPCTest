class TasksController < ApplicationController
  load_and_authorize_resource
  
  def index
    @project = Project.find(params[:project_id_param])
    @tasks = Task.all.order(created_at: :desc)
  end

  def new
    @project = Project.find(params[:project_id_param])
    @task = @project.tasks.new()
  end

  def create
    @task = Task.new(task_params)
       
    if @task.save      
      redirect_to controller: 'home', action: 'show', id: @task.project_id
      flash[:notice] = "Task was successfully created"
    else
      flash[:alert] = "There was a problem creating task"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to controller: 'home', action: 'show', id: @task.project_id
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
    params.require(:task).permit(:id, :executor, :task, :project_id)
  end

end
