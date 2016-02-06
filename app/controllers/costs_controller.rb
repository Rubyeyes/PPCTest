class CostsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = current_user
    # advance search filter
    filter(Cost)
    @costs = @data.text_sort(params[:sort], params[:direction]).page(params[:page]).per(20)
    if params[:project_id_param].present?
      @project = Project.find(params[:project_id_param])
      @costs = @project.costs 
    end
  end

  def new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @cost = Cost.new
  end

  def create
    @cost = Cost.new(cost_params)
    # @users = User.notification_recipients(@cost, current_user, params[:controller])   
    if @cost.save
      # @users.each do |user|
      #   Notification.create_notification(@cost, "create cost of", current_user.id, user.id, params[:controller])
      # end
      redirect_to costs_path
      flash[:notice] = "Cost was successfully created"
    else
      flash[:alert] = "There was a problem creating cost"
      render :new
    end
  end

  def edit
    @cost = Cost.find(params[:id])
    if current_user.role == "factory" && @cost.project.user.fullname != current_user.fullname
      # redirect_to root_path
      # flash[:alert] = "You have no authorization"
      raise Forbidden, "You have no authorization to visit this page" 
    end
  end

  def update
    @cost = Cost.find(params[:id])
    @users = User.notification_recipients(@cost, current_user, params[:controller])  
    if @cost.update(cost_params)
      # @users.each do |user|
      #   Notification.create_notification(@cost, "update the cost of", current_user.id, user.id, params[:controller])
      # end
      redirect_to costs_path
      flash[:notice] = "Cost was successfully updated"
    else
      flash[:alert] = "There was a problem updating cost"
      render :edit
    end
  end

  def destroy
    @cost = Cost.find(params[:id])
    Product.where(cost_id: @cost.id).each do |product|
      product.update(cost_id: nil)
    end
    @cost.destroy
    redirect_to :back, notice: "Cost was successfully deleted"
  end

# Private parameters
  private

  def cost_params
    params.require(:cost).permit(:id, :unitUSD, :toolingUSD, :unitRMB, :toolingRMB, :ratio, :description, :project_id)
  end

  def notification_params
    params.require(:notification).permit(:id, :content, :item, :notifiable_id, :notifiable_type, :user_id)
  end
end
