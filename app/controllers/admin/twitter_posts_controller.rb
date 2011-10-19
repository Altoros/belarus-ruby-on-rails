class Admin::TwitterPostsController < ApplicationController
  load_and_authorize_resource

  def edit
    @twitter_post = TwitterPost.first
  end

  def update
    @twitter_post = TwitterPost.first

    respond_to do |format|
      if @twitter_post.update_attributes(params[:twitter_post])
        format.html { redirect_to edit_admin_twitter_post_path(@twitter_post), :notice => t('twitter_posts.successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @twitter_post.errors, :status => :unprocessable_entity }
      end
    end
  end

end
