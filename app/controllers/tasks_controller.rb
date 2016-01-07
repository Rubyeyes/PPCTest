class TasksController < ApplicationController
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
      redirect_to controller: 'home', action: 'show', id: task_params[:project_id].to_i, notice: "Product was successfully created"
    else
      flash[:alert] = "There was a problem creating task"
      render :new
    end
  end

  def edit
  end

  def update
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
