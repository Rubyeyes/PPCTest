class SamplesController < ApplicationController
  load_and_authorize_resource
  
  def index
    if current_user != 'factory'
      @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
      @sammples = Sample.all.order(created_at: :desc)
    else
      @samples = Sample.match_current_user(current_user.id).order(created_at: :desc).page params[:page]
    end
  end

  def new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @sample = Sample.new()
  end

  def create
    @sample = Sample.new(sample_params)
   
    if @sample.save      
      redirect_to controller: 'home', action: 'show', id: @sample.project_id
      flash[:notice] = "Sample was successfully created"
    else
      flash[:alert] = "There was a problem creating sample"
      render :new
    end
  end

  def edit
    @sample = Sample.find(params[:id])
  end

  def update
    @sample = Sample.find(params[:id])
    if @sample.update(sample_params)
      redirect_to controller: 'home', action: 'show', id: @sample.project_id
      flash[:notice] = "Sample was successfully updated"
    else
      flash[:alert] = "There was a problem updating sample"
      render :edit
    end
  end

  def show
  end

  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy
    redirect_to :back, notice: "Sample was successfully deleted"
  end

  private

  def sample_params
    params.require(:sample).permit(:id, :receive_date, :quantity, :description, :project_id)
  end

end
