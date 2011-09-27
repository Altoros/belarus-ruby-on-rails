class CommentsController < ApplicationController
  load_and_authorize_resource

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    custom_news = CustomNews.find(params[:custom_news_id])
    @comment = custom_news.comments.build params[:comment]
    @comment.user = current_user
    @comment.save
  end

  def update
    custom_news = CustomNews.find(params[:custom_news_id])
    @comment = custom_news.comments.find(params[:id])
    @comment.update_attributes(params[:comment])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
