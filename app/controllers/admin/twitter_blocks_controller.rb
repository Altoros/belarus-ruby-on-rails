class Admin::TwitterBlocksController < ApplicationController
  load_and_authorize_resource

  def edit
    @twitter_block = TwitterBlock.first
  end

  def update
    @twitter_block = TwitterBlock.first

    respond_to do |format|
      if @twitter_block.update_attributes(params[:twitter_block])
        format.html { redirect_to edit_admin_twitter_block_path(@twitter_block), :notice => t('twitter_block.successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @twitter_block.errors, :status => :unprocessable_entity }
      end
    end
  end

end
