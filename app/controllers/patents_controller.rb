class PatentsController < ApplicationController
  def index
    @user = current_user
    # advance search filter
    filter(Patent)
    @patents = @data.uniq.text_sort(params[:sort], params[:direction]).page(params[:page]).per(20)
    if params[:project_id_param].present?
      @project = Project.find(params[:project_id_param])
      @patents = @project.patents.text_sort(params[:sort], params[:direction]).page(params[:page]).per(20)  
    end
  end

  def new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
    @patent = Patent.new
    @patent_projects = @patent.patent_projects.all
    if current_user.role == "factory"
      @projects = Project.where(user_id: current_user.id).order(project_name: :asc)
    elsif current_user.role == "admin" || "user" || "user2"
      @projects = Project.all.order(project_name: :asc)
    end
  end

  def create
    @patent = Patent.new(patent_params)
      # @users = User.notification_recipients(@patent, current_user, params[:controller])   
    if @patent.save
      # @users.each do |user|
      #   Notification.create_notification(@patent, "create patent of", current_user.id, user.id, params[:controller])
      # end
      redirect_to new_patent_project_path(patent_id: @patent.id)
      flash[:notice] = "Patent was successfully created"
    else
      flash[:alert] = "There was a problem creating patent"
      render :new
    end
  end

  def edit
    @patent = Patent.find(params[:id])
    @patent_projects = PatentProject.where patent_id: @patent.id
    if current_user.role == "factory" && @patent_projects.joins(:project).where("user_id = ?", @user.id).empty?
      # redirect_to root_path
      # flash[:alert] = "You have no authorization"
      raise Forbidden, "You have no authorization to visit this page" 
    end
  end

  def update
    @patent = Patent.find(params[:id])
    @users = User.notification_recipients(@patent, current_user, params[:controller])        
    if @patent.update(patent_params)
      # @users.each do |user|
      #   Notification.create_notification(@patent, "update the patent of", current_user.id, user.id, params[:controller])
      # end
      redirect_to new_patent_project_path(patent_id: @patent.id)
      flash[:notice] = "Patent was successfully updated"
    else
      flash[:alert] = "There was a problem updating patent"
      render :edit
    end
  end

  def show
  end

  def destroy
    @patent = Patent.find(params[:id])
    @patent.destroy
    redirect_to patents_path, notice: "Patent was successfully deleted"
  end

  private

  def patent_params
    params.require(:patent).permit(:id, :name, :patent_type, :docket_number, :certificate, :status, :patent_number, :patent_number, :issue_date, :filling_date)
  end

end
