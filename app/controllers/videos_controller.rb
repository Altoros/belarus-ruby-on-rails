class VideosController < ApplicationController
  def index
    @videos = Video.paginate(
      :per_page => 5,
      :page => params[:page],
      :order => 'published_at DESC'
    )
  end

  def show
    @video = Video.find(params[:id])
  end
end
