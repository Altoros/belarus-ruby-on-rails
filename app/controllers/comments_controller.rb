class CommentsController < ApplicationController
  include CommentsHelper

  def edit
    @comment = Comment.find(params[:id])
    filter :change_comment, @comment
  end

  def create
    if filter :add_comment
      @comment = Comment.new(params[:comment])
      @comment.user = current_user
      @comment.save
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if filter :change_comment, @comment
      @comment.update_attributes(params[:comment])
      @saved = CustomNews.exists?(@comment.custom_news) and @comment.save
      @notify = @saved ? "Comment was successfully changed" :
                         "Comment was not saved"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if filter :remove_comment, @comment
  end
end
