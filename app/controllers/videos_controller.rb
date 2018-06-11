class VideosController < ApplicationController
  def index
    @videos = Video.order('published_at DESC').paginate(per_page: 5, page: params[:page])
  end

  def show
    @video = Video.find(params[:id])
  end
end
