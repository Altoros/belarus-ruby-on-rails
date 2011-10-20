class Admin::ArticlesController < ApplicationController
  load_and_authorize_resource

  # GET /admin/articles
  # GET /admin/articles.json
  def index
    authorize! :admin, :dashboard
    @articles = Article.internal.paginate(
      :per_page => 20,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.json
  def new
    @article = Article.internal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @article }
    end
  end

  # GET /admin/articles/1/edit
  def edit
    @article = Article.internal.find(params[:id])
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @article = Article.internal.new(params[:article])
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_path, :notice => t('articles.article_successfully_created') }
        format.json { render :json => @article, :status => :created, :location => @articles }
      else
        format.html { render :action => "new" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.json
  def update
    @article = Article.internal.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to edit_admin_article_path(@article), :notice => t('articles.article_successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @article = Article.internal.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_path, :notice => t('articles.article_successfully_deleted') }
      format.json { head :ok }
    end
  end
end
