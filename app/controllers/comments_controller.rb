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
      @comment.custom_news = CustomNews.find params[:custom_news]
      @saved = @comment.save
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if filter :change_comment, @comment
      @comment.update_attributes(params[:comment])
      @saved = @comment.save
      @notify = @saved ? "Comment was successfully changed" :
                         "Comment body is too short. Its length must be grater then 4"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if filter :remove_comment, @comment
  end
end
