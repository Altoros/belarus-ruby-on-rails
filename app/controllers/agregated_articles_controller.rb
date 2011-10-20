class AgregatedArticlesController < ApplicationController
  load_and_authorize_resource

  # GET /agregated_articles
  # GET /agregated_articles.json
  def index
    @articles = AgregatedArticle.external.published.paginate(
      :per_page => 5,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /agregated_articles/1
  # GET /agregated_articles/1.json
  def show
    @article = AgregatedArticle.external.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

end
