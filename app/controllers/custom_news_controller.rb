class CustomNewsController < ApplicationController
  # GET /custom_news
  # GET /custom_news.json
  def index
    @custom_news = CustomNews.paginate(
      :per_page => 5,
      :page => params[:page],
      :order => 'created_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @custom_news }
    end
  end

  # GET /custom_news/1
  # GET /custom_news/1.json
  def show
    @custom_news = CustomNews.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @custom_news }
    end
  end

  # GET /custom_news/new
  # GET /custom_news/new.json
  def new
    @custom_news = CustomNews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @custom_news }
    end
  end

  # GET /custom_news/1/edit
  def edit
    @custom_news = CustomNews.find(params[:id])
  end

  # POST /custom_news
  # POST /custom_news.json
  def create
    @custom_news = CustomNews.new(params[:custom_news])

    respond_to do |format|
      if @custom_news.save
        format.html { redirect_to @custom_news, notice: 'Custom news was successfully created.' }
        format.json { render json: @custom_news, status: :created, location: @custom_news }
      else
        format.html { render action: "new" }
        format.json { render json: @custom_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /custom_news/1
  # PUT /custom_news/1.json
  def update
    @custom_news = CustomNews.find(params[:id])

    respond_to do |format|
      if @custom_news.update_attributes(params[:custom_news])
        format.html { redirect_to @custom_news, notice: 'Custom news was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @custom_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_news/1
  # DELETE /custom_news/1.json
  def destroy
    @custom_news = CustomNews.find(params[:id])
    @custom_news.destroy

    respond_to do |format|
      format.html { redirect_to custom_news_index_url, notice: 'Custom news was successfully deleted.' }
      format.json { head :ok }
    end
  end
end
