class ArticlesController < ApplicationController
  load_and_authorize_resource

  has_widgets do |root|
    root << widget(:meetup, :user => current_user)
  end

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.published.paginate(
      :per_page => 5,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @share = {:title => @article.title}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

end
