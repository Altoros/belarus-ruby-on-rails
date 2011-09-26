class CommentsController < ApplicationController

  def edit
    @comment = Comment.find(params[:id])
    filter :change_comment, @comment
  end

  def create
    @comment = CustomNews.find(params[:custom_news_id]).comments.build params[:comment]
    @comment.user = current_user
    @comment.save
  end

  def update
    @custom_news = CustomNews.find(params[:custom_news_id])
    @comment = @custom_news.comments.find(params[:id])
    if filter :change_comment, @comment
      @comment.update_attributes(params[:comment])
      @saved = @comment.save
      @notify = @saved ? "Comment was successfully changed" :
                         "Comment was not saved"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if filter :remove_comment, @comment
  end
end
