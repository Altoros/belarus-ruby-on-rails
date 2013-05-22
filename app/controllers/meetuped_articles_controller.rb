class MeetupedArticlesController < ApplicationController

  # GET /meetuped_articles
  # GET /meetuped_articles.json
  def index
    @articles = Article.meetuped.paginate(
      :per_page => 5,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @articles }
    end
  end

  # GET /meetuped_articles/1
  # GET /meetuped_articles/1.json
  def show
    @article = Article.meetuped.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @article }
    end
  end

  def download_ics
    meetup = Meetup.find(params[:id])

    send_data meetup.export_to_ics, :filename => 'meetup.ics'
  end

end
