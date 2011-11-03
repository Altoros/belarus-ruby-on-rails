class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build params[:comment]
    @comment.user = current_user
    @comment.parent = Comment.find(params[:parent_id]) if params[:parent_id]

    is_create = @comment.save

    if is_create
      comment_html = render_to_string( :partial => "comments/show.html", :locals => { :comment => @comment } )
      form_html = render_to_string( :partial => "comments/form.html",
                                    :locals => { :comment => @article.comments.build } )

      # send notification to all participants of discussion exclude commentator
      @comment.delay.deliver
    else
      form_html = render_to_string( :partial => "comments/form.html", :locals => { :comment => @comment } )
    end

    render :json => { :create_status => is_create, :form_html => form_html,
                      :comment_html => comment_html, :comments_count => @article.comments.count }
  end

  def edit
    @comment = Comment.find(params[:id])
    form_html = render_to_string( :partial => "comments/form.html",
                                  :locals => { :comment => @comment } )

    render :json => { :form_html => form_html }
  end

  def new
    @parent_comment = Comment.find(params[:comment_id])
    @comment = @parent_comment.article.comments.build
    @comment.parent = @parent_comment
    form_html = render_to_string( :partial => "comments/form.html", :locals => { :comment => @comment } )

    render :json => { :form_html => form_html }
  end

  def update
    @comment = Comment.find(params[:id])
    is_updated = @comment.update_attributes(params[:comment])

    content = is_updated ? render_to_string( :partial => "comments/show.html", :locals => { :comment => @comment } ) :
        render_to_string( :partial => "comments/form.html", :locals => { :comment => @comment } )

    render :json => { :update_status => is_updated, :content_html => content }
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    render :json => { :comment_div_id => dom_id(@comment), :comments_count => @comment.article.comments.count }
  end
end
