class CostsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @costs = Cost.all
  end

  def new
    @project = Project.find(params[:project_id_param])
    @cost = @project.costs.new()
  end

  def create
    @cost = Cost.new(cost_params)
   
    if @cost.save      
      redirect_to controller: 'home', action: 'show', id: @cost.project_id 
      flash[:notice] = "Cost was successfully created"
    else
      flash[:alert] = "There was a problem creating cost"
      render :new
    end
  end

  def edit
    @cost = Cost.find(params[:id])
  end

  def update
    @cost = Cost.find(params[:id])
    if @cost.update(cost_params)
      redirect_to controller: 'home', action: 'show', id: @cost.project_id
      flash[:notice] = "Cost was successfully updated"
    else
      flash[:alert] = "There was a problem updating cost"
      render :edit
    end
  end

  def show
  end

  def destroy
    @cost = Cost.find(params[:id])
    @cost.destroy
    redirect_to :back, notice: "Cost was successfully deleted"
  end

  private

  def cost_params
    params.require(:cost).permit(:id, :unitUSD, :toolingUSD, :unitRMB, :toolingRMB, :ratio, :description, :project_id)
  end
end
