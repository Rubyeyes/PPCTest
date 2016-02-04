class InstructionsController < ApplicationController
  def index
  end

  def new
    @instruction = Instruction.new
    @project = Project.find(params[:project_id_param]) if params[:project_id_param].present?
  end

  def create
    @instruction = Instruction.new(instruction_params)
    # @users = User.notification_recipients(@instruction, current_user, params[:controller])   
    if @instruction.save
      # @users.each do |user|
      #   Notification.create_notification(@instruction, "create instruction of", current_user.id, user.id, params[:controller])
      # end
      redirect_to project_path(@instruction.project.id)
      flash[:notice] = "Instruction was successfully created"
    else
      flash[:alert] = "There was a problem uploading Instruction"
      render :new
    end
  end

  def edit
    @instruction = Instruction.find(params[:id])
    if current_user.role == "factory" && @instruction.project.user.fullname != current_user.fullname
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @instruction = Instruction.find(params[:id])
    @users = User.notification_recipients(@instruction, current_user, params[:controller])  
    if @instruction.update(instruction_params)
      # @users.each do |user|
      #   Notification.create_notification(@instruction, "update the instruction of", current_user.id, user.id, params[:controller])
      # end
      redirect_to project_path(@instruction.project.id)
      flash[:notice] = "instruction was successfully updated"
    else
      flash[:alert] = "There was a problem updating instruction"
      render :edit
    end
  end

  def show
  end

  def destroy
    @instruction = Instruction.find(params[:id])
    @instruction.remove_instruction!
    @instruction.destroy
    redirect_to :back, notice: "instruction was successfully deleted"
  end

  private

  def instruction_params
    params.require(:instruction).permit(:id, :instruction, :description, :project_id)
  end
end
