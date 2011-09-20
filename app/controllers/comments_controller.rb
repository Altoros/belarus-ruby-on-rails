class CommentsController < ApplicationController
  before_filter :add_filter, only: [ :create ]

  def edit
    @comment = Comment.find(params[:id])
    filter_ajax :change_comment, @comment
  end

  def create
 		@comment = Comment.new(params[:comment])
    @comment.user = current_user
		@comment.custom_news = CustomNews.find params[:id]
    if @comment.save
      @saved = true
    else
      @saved = false
    end
  end

  def update
    @saved = false
    @comment = Comment.find(params[:id])
    filter_ajax :change_comment, @comment
    @comment.update_attributes(params[:comment])
    if @comment.save
      @saved = true
      @notify = "Comment #{ params[:id] } was successfully changed"
    else
      @notify = "Comment #{ params[:id] } body is too little. Its length must be grater then 4"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    filter_ajax :remove_comment, @comment
    @comment.destroy
    @div_id = "comment" + params[:id].to_s
  end

  private
  def add_filter
    filter_ajax(:add_comment)
  end

end