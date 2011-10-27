class ArticlesController < ApplicationController
  load_and_authorize_resource

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.includes(:comments, :user => :profile).internal.published.paginate(
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
    @article = Article.includes(:comments, :user => :profile).internal.find(params[:id])
    @share = { :title => @article.title }

# Could be used to avoid from duplicate link for SEO purpose
=begin
    if request.path != article_path(@article)
      return redirect_to @article, :status => :moved_permanently
    end
=end

    respond_to do |format|
      format.html
      format.json { render :json => @article }
    end
  end

end
