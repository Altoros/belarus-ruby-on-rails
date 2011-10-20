class AggregatedArticlesController < ApplicationController
  load_and_authorize_resource

  # GET /aggregated_articles
  # GET /aggregated_articles.json
  def index
    @articles = AggregatedArticle.published.paginate(
      :per_page => 5,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /aggregated_articles/1
  # GET /aggregated_articles/1.json
  def show
    @article = AggregatedArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

end
