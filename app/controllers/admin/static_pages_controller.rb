class Admin::StaticPagesController < ApplicationController
  load_and_authorize_resource

  def index
    authorize! :admin, :dashboard
    @static_pages = StaticPage.all

    respond_to do |format|
      format.html
      format.json { render :json => @static_pages }
    end
  end


  def new
    @static_page = StaticPage.new

    respond_to do |format|
      format.html
      format.json { render json: @static_page }
    end
  end


  def edit
    if params[:permalink]
      @static_page = StaticPage.find_by_permalink(params[:permalink])
    else
      @static_page = StaticPage.find(params[:id])
    end
  end


  def create
    @static_page = StaticPage.new(params[:static_page])

    respond_to do |format|
      if @static_page.save
        format.html { redirect_to admin_static_pages_path, :notice => t('static_pages.created') }
        format.json { render :json => @static_page, status: :created, :location => @static_pages }
      else
        format.html { render :action => "new" }
        format.json { render :json => @static_page.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    if params[:permalink]
      @static_page = StaticPage.find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, t('static_pages.not_found') if @static_page.nil?
    else
      @static_page = StaticPage.find(params[:id])
    end

    respond_to do |format|
      if @static_page.update_attributes(params[:static_page])
        format.html { redirect_to static_page_path(:permalink => @static_page.permalink), :notice => t('static_pages.page_successfully_updated') }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    if params[:permalink]
      @static_page = StaticPage.find_by_permalink(params[:permalink])
      raise ActiveRecord::RecordNotFound, t('static_pages.not_found') if @static_page.nil?
    else
      @static_page = StaticPage.find(params[:id])
    end

    @static_page.destroy

    respond_to do |format|
      format.html { redirect_to admin_static_pages_path, :notice => t('static_pages.deleted') }
      format.json { head :ok }
    end
  end
end
