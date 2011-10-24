class StaticPagesController < ApplicationController
  load_and_authorize_resource

  def show
    if params[:permalink]
      @static_page = StaticPage.find_by_permalink(params[:permalink])
    else
      @static_page = StaticPage.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @static_page }
    end
  end
end