class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)   
    if @video.save
      redirect_to videos_path
      flash[:notice] = "video was successfully created"
    else
      flash[:alert] = "There was a problem uploading video"
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
    if current_user.role == "factory" && @video.project.user.fullname != current_user.fullname
      redirect_to root_path
      flash[:alert] = "You have no authorization"
    end
  end

  def update
    @video = Video.find(params[:id]) 
    if @video.update(video_params)
      redirect_to project_path(@video.project_id)
      flash[:notice] = "video was successfully updated"
    else
      flash[:alert] = "There was a problem updating video"
      render :edit
    end
  end

  def show
  end

  def destroy
    @video = Video.find(params[:id])
    @video.remove_video!
    @video.destroy
    redirect_to :back, notice: "video was successfully deleted"
  end

  private

  def video_params
    params.require(:video).permit(:id, :video, :description)
  end
end
