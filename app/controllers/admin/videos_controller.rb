class Admin::VideosController < ApplicationController
  load_and_authorize_resource
  before_filter :find_video, :only => [:destroy, :update]

  def index
    authorize! :admin, :dashboard
    @videos = Video.paginate(
      :per_page => 20,
      :page => params[:page],
      :order => 'created_at DESC'
    )
  end

  def fetch
    client = YouTubeIt::Client.new(:dev_key => SOCIAL_CONFIG['youtube']['dev_key'])
    fetched_videos = client.videos_by(:user => SOCIAL_CONFIG['youtube']['username']).videos

    @videos = Video.screening(fetched_videos).paginate(
      :per_page => 5,
      :page => params[:page]
    )
  end

  def create
    Video.create(params[:fetched_video])
    redirect_to admin_videos_path
  end

  def destroy
    @video.destroy
    redirect_to admin_videos_path
  end

  def update
    @video.update_attributes(params[:video])
    redirect_to admin_videos_path
  end

  private
  def find_video
   @video = Video.find(params[:id])
  end
end