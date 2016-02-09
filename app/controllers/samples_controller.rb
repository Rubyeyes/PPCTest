class SamplesController < ApplicationController
  load_and_authorize_resource
  
  def index
    @user = current_user
    # advance search filter
    filter(Sample)
    @samples = @data.text_sort(params[:sort], params[:direction]).page(params[:page]).per(20)
    if params[:project_id_param].present?
      @project = Project.find(params[:project_id_param])
      @samples = @project.samples 
    end
  end

  def new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @sample = Sample.new()
  end

  def create
    @sample = Sample.new(sample_params)
    @users = User.notification_recipients(@sample, current_user, params[:controller])    
   
    if @sample.save
      # @users.each do |user|
      #   Notification.create_notification(@sample, "created sample of", current_user.id, user.id, params[:controller])
      # end      
      redirect_to controller: 'projects', action: 'show', id: @sample.project_id
      flash[:notice] = "Sample was successfully created"
    else
      flash[:alert] = "There was a problem creating sample"
      render :new
    end
  end

  def edit
    @sample = Sample.find(params[:id])
    if current_user.role == "factory" && @sample.project.user.fullname != current_user.fullname
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @sample = Sample.find(params[:id])
    @users = User.notification_recipients(@sample, current_user, params[:controller])    
   
    if @sample.update(sample_params)
      # @users.each do |user|
      #   Notification.create_notification(@sample, "updated sample of", current_user.id, user.id, params[:controller])
      # end
      redirect_to controller: 'projects', action: 'show', id: @sample.project_id
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
    params.require(:sample).permit(:id, :receive_date, :quantity, :description, :project_id, :date, :received)
  end

end
