class ReportsController < ApplicationController
  def index
    @user = current_user
    @filter = Report.text_filter(params[:filter].to_s)
    @search = @filter.text_search(params[:query].to_s)
    @reports = @search.user_filter(@user).text_sort(params[:sort], params[:direction]).page params[:page] 
  end

  def new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @users = User.notification_recipients(@report, current_user, params[:controller])
       
    if @report.save      
      @users.each do |user|
        Notification.create_notification(@report, "created report of", current_user.id, user.id, params[:controller])
      end     
      redirect_to reports_path
      flash[:notice] = "Report was successfully created"
    else
      flash[:alert] = "There was a problem creating report"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @report = Report.find(params[:id])
  end

  def update
     @report = Report.find(params[:id])
     @users = User.notification_recipients(@report, current_user, params[:controller])
    if @report.update(report_params)      
      @users.each do |user|
        Notification.create_notification(@report, "updated report of", current_user.id, user.id, params[:controller])
      end
      redirect_to reports_path
      flash[:notice] = "Report was successfully updated"
    else
      flash[:alert] = "There was a problem updating report"
      render :edit
    end
  end

  def show
    @report = Report.find(params[:id])
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to :back, notice: "Report was successfully deleted"
  end

  private

  def report_params
    params.require(:report).permit(:id, :name, :content, :project_id)
  end

end
