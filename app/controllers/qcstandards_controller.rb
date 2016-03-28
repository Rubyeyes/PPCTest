class QcstandardsController < ApplicationController

  respond_to :json

  def index
    @qcstandards = Qcstandard.all
    respond_with @qcstandards
  end

  def new
    @qcstandard = Qcstandard.new
    respond_with @qcstandard
  end

  def create
    @qcstandard = Qcstandard.new(qcstandard_params)
    # @users = User.notification_recipients(@qcstandard, current_user, params[:controller])   
    if @qcstandard.save
      # @users.each do |user|
      #   Notification.create_notification(@qcstandard, "create qcstandard of", current_user.id, user.id, params[:controller])
      # end
      flash[:notice] = "qcstandard was successfully created"
    else
      flash[:alert] = "There was a problem uploading qcstandard"
    end
    respond_with @qcstandard
  end

  def edit
    @qcstandard = Qcstandard.find(params[:id])
    if current_user.role == "factory" && @qcstandard.project.user.fullname != current_user.fullname
      flash[:alert] = "You have no authorization"
    end
    respond_with @qcstandard
  end

  def update
    @qcstandard = Qcstandard.find(params[:id])
    @users = User.notification_recipients(@qcstandard, current_user, params[:controller])  
    if @qcstandard.update(qcstandard_params)
      # @users.each do |user|
      #   Notification.create_notification(@qcstandard, "update the qcstandard of", current_user.id, user.id, params[:controller])
      # end
      flash[:notice] = "qcstandard was successfully updated"
    else
      flash[:alert] = "There was a problem updating qcstandard"
    end
    respond_with @qcstandard
  end

  def show
    @qcstandard = Qcstandard.find(params[:id])
    respond_with @qcstandard
  end

  def destroy
    @qcstandard = Qcstandard.find(params[:id])
    @qcstandard.remove_file!
    @qcstandard.destroy
    respond_with @qcstandard
  end

  private

  def qcstandard_params
    params.require(:qcstandard).permit(:id, :file, :description, :project_id)
  end

end
