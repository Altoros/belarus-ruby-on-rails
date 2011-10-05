class CommentsController < ApplicationController
  load_and_authorize_resource

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build params[:comment]
    @comment.user = current_user
    @comment.save

    if (params[:receive_email] == 'yes')
      @comments_subscription = CommentsSubscription.new(:profile_id => current_user.profile.id,
                                                         :article_id => params[:article_id])
      @comments_subscription.save
    end
  end

  def update
    articles = Article.find(params[:article_id])
    @comment = articles.comments.find(params[:id])
    @comment.update_attributes(params[:comment])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
