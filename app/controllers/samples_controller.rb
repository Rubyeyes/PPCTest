class SamplesController < ApplicationController
  def index
    @project = Project.find(params[:project_id_param])
    @sammples = Sample.all.order(created_at: :desc)
  end

  def new
    @project = Project.find(params[:project_id_param])
    @sample = @project.samples.new()
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
