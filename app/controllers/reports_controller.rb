class ReportsController < ApplicationController
  def index
    if current_user.role != 'factory'
      @reports = Report.all.order(created_at: :desc).page params[:page]
    else
      @reports = Report.match_current_user(current_user.id).order(created_at: :desc).page params[:page]
    end
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
   
    if @report.save      
      redirect_to reports_path
      flash[:notice] = "Report was successfully created"
    else
      flash[:alert] = "There was a problem creating report"
      render :new
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
     @report = Report.find(params[:id])
    if @report.update(report_params)
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
