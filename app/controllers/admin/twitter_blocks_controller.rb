class Admin::TwitterBlocksController < ApplicationController
  load_and_authorize_resource

  # GET /admin/twitter_block
  # GET /admin/twitter_block.json
  def index
    authorize! :admin, :dashboard
    @twitter_blocks = TwitterBlock.paginate(
      :per_page => 20,
      :page => params[:page],
      :order => 'id ASC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @twitter_blocks }
    end
  end

  # GET /admin/twitter_block/new
  # GET /admin/twitter_block/new.json
  def new
    @twitter_block = TwitterBlock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @twitter_block }
    end
  end

  def edit
    @twitter_block = TwitterBlock.find(params[:id])
  end

  # POST /admin/twitter_blocks
  # POST /admin/twitter_blocks.json
  def create
    @twitter_block = TwitterBlock.new(params[:twitter_block])

    respond_to do |format|
      if @twitter_block.save
        format.html { redirect_to edit_admin_twitter_block_path(@twitter_block), :notice => t('twitter_blocks.successfully_created') }
        format.json { render :json => @twitter_block, :status => :created, :location => @twitter_block }
      else
        format.html { render :action => "new" }
        format.json { render :json => @twitter_block.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @twitter_block = TwitterBlock.find(params[:id])

    respond_to do |format|
      if @twitter_block.update_attributes(params[:twitter_block])
        format.html { redirect_to edit_admin_twitter_block_path(@twitter_block), :notice => t('twitter_blocks.successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @twitter_block.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/twitter_blocks/1
  # DELETE /admin/twitter_blocks/1.json
  def destroy
    @twitter_block = TwitterBlock.find(params[:id])
    @twitter_block.destroy

    respond_to do |format|
      format.html { redirect_to admin_twitter_blocks_path, :notice => t('twitter_blocks.successfully_deleted') }
      format.json { head :ok }
    end
  end

end
