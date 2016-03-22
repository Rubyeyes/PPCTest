class QcstandardsController < ApplicationController
  def index
  end

  def new
    @qcstandard = Qcstandard.new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
  end

  def create
    @qcstandard = Qcstandard.new(qcstandard_params)
    # @users = User.notification_recipients(@qcstandard, current_user, params[:controller])   
    if @qcstandard.save
      # @users.each do |user|
      #   Notification.create_notification(@qcstandard, "create qcstandard of", current_user.id, user.id, params[:controller])
      # end
      redirect_to project_path(id: @qcstandard.project.id)
      flash[:notice] = "qcstandard was successfully created"
    else
      flash[:alert] = "There was a problem uploading qcstandard"
      render :new
    end
  end

  def edit
    @qcstandard = Qcstandard.find(params[:id])
    if current_user.role == "factory" && @qcstandard.project.user.fullname != current_user.fullname
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @qcstandard = Qcstandard.find(params[:id])
    @users = User.notification_recipients(@qcstandard, current_user, params[:controller])  
    if @qcstandard.update(qcstandard_params)
      # @users.each do |user|
      #   Notification.create_notification(@qcstandard, "update the qcstandard of", current_user.id, user.id, params[:controller])
      # end
      redirect_to project_path(id: @qcstandard.project.id)
      flash[:notice] = "qcstandard was successfully updated"
    else
      flash[:alert] = "There was a problem updating qcstandard"
      render :edit
    end
  end

  def show
  end

  def destroy
    @qcstandard = Qcstandard.find(params[:id])
    @qcstandard.remove_file!
    @qcstandard.destroy
    redirect_to :back, notice: "qcstandard was successfully deleted"
  end

  private

  def qcstandard_params
    params.require(:qcstandard).permit(:id, :file, :description, :project_id)
  end
end
