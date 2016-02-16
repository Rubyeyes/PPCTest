class PatentProjectsController < ApplicationController

  def new
    @patent_project = PatentProject.new
    @patent = Patent.find(params[:patent_id])
    @patent_projects = PatentProject.where(patent_id: @patent.id)
  end

  def create
    @patent_project = PatentProject.new(patent_project_params)
      # @users = User.notification_recipients(@patent, current_user, params[:controller])   
    if @patent_project.save
      # @users.each do |user|
      #   Notification.create_notification(@patent, "create patent of", current_user.id, user.id, params[:controller])
      # end
      redirect_to :back
      flash[:notice] = "Patent was successfully created"
    else
      flash[:alert] = "There was a problem creating patent"
      render :new
    end
  end

  def destroy
    @patent_project = PatentProject.find(params[:id])
    @patent_project.destroy
    redirect_to :back, notice: "Patent was successfully deleted"
  end

  private

  def patent_project_params
    params.require(:patent_project).permit(:id, :patent_id, :project_id)
  end
end
