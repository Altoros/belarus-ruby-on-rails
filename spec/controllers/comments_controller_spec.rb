require 'spec_helper'

describe CommentsController do

  before :each do
    @comment = Factory(:comment, :custom_news_id => Factory(:custom_news).id, :user => Factory(:user))
  end

  describe  "as signed in user" do

    before :each do
      sign_in @comment.user
    end

    it "should render edit template on edit action" do
      xhr :get, :edit, { :id => @comment }
      response.should render_template "comments/edit"
    end

    it "should render update template on update action by ajax" do
      xhr :get, :update, { :id => @comment, :comment => { :body => "new text" }, :custom_news_id => @comment.custom_news_id }
      response.should render_template "comments/update"
    end

    it "should update comment on update action by ajax" do
      original_comment_body = @comment.body
      xhr :get, :update, { :id => @comment, :comment => { :body => "new text" }, :custom_news_id => @comment.custom_news_id }
      Comment.find(@comment.id).body.should_not be_eql original_comment_body
    end

    it "should not update comment on update action by ajax with invalid comment's body" do
      original_comment_body = @comment.body
      xhr :get, :update, { :id => @comment, :comment => { :body => "+1" }, :custom_news_id => @comment.custom_news_id }
      Comment.find(@comment).body.should be_eql original_comment_body
    end

    it "should render destroy template on destroy action by ajax" do
      xhr :get, :destroy, { :id => @comment }
      response.should render_template "comments/destroy"
    end

    it "should delete the comment on destroy action by ajax" do
      xhr :get, :destroy, :id => @comment
      Comment.exists?(@comment).should be_false
    end

    it "should render create template on create action by ajax" do
      xhr :get, :create, :comment => { :body => "I'm a Test comment"}, :custom_news_id => @comment.custom_news.id
      response.should render_template "comments/create"
    end

    it "should create comment on create action by ajax" do
      comments_count = Comment.all.length
      xhr :get, :create, :comment => { :body => "I'm a Test comment"}, :custom_news_id => @comment.custom_news.id
      comments_count.should_not be_eql Comment.all.length
    end

    it "can't create a comment if comment body is invalid on create action by ajax" do
      comments_count = Comment.all.length
      xhr :get, :create, :comment => { :body => "+1"}, :custom_news_id => @comment.custom_news.id
      comments_count.should be_eql Comment.all.length
    end

    it "should not access to remove comment on which user doesn't owner" do
      @stranger_user = Factory(:user, :email => "user2@test.com")
      @stranger_comment = Factory(:comment, :custom_news_id => Factory(:custom_news).id, :user => @stranger_user)
      xhr :get, :destroy, :id => @stranger_comment
      Comment.exists?(@stranger_comment).should be_true
    end

    it "should not access to update custom_news_id for comment" do
      stranger_custom_news = Factory :custom_news
      original_news = @comment.custom_news_id
      xhr :get, :update, :id => @comment, :comment => { :body => "I'm updated comment", :custom_news_id => stranger_custom_news.id }, :custom_news_id => @comment.custom_news.id
      original_news.should be_eql Comment.find(@comment.id).custom_news_id
    end

    it "should not access to update owner for comment" do
      stranger_user = Factory(:user, :email => "user2@test.com")
      original_owner = @comment.user_id
      xhr :get, :update, :id => @comment, :comment => { :body => "I'm updated comment", :user_id => stranger_user.id }, :custom_news_id => @comment.custom_news.id
      original_owner.should be_eql Comment.find(@comment.id).user_id
    end

    it "should not access to create comment with invalid custom_news_id" do
      stranger_custom_news = Factory :custom_news
      original_news = @comment.custom_news_id
      body = "I'm a new comment"
      xhr :get, :create, :comment => { :body => body, :custom_news_id => stranger_custom_news.id }, :custom_news_id => @comment.custom_news.id
      original_news.should be_eql Comment.find_by_body(body).custom_news_id
    end
  end

  describe "as signed out user" do
    it "should not render update template on update action by ajax" do
      xhr :get, :update, { :id => @comment, :comment => { :body => "new text" }, :custom_news_id => @comment.custom_news_id }
      response.should_not render_template "comments/update"
    end
  end
end