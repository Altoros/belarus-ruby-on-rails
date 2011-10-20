class Admin::AggregatedArticlesController < ApplicationController
  load_and_authorize_resource

  # GET /admin/aggregated_articles
  # GET /admin/aggregated_articles.json
  def index
    authorize! :admin, :dashboard
    @articles = AggregatedArticle.paginate(
      :per_page => 20,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # DELETE /admin/aggregated_articles/1
  # DELETE /admin/aggregated_articles/1.json
  def destroy
    @article = AggregatedArticle.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to admin_aggregated_articles_path, :notice => t('articles.article_successfully_deleted') }
      format.json { head :ok }
    end
  end
end
