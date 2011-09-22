require 'spec_helper'

describe CommentsController do
  describe  "as signed in user" do
    before :each do
      @comment = Comment.create({
          body: "I'm a first comment",
          custom_news: Factory(:custom_news),
          user: Factory(:user)
                                })
      sign_in @comment.user
    end

    it "should render edit template on edit action" do
      xhr :get, :edit, { id: @comment }
      response.should render_template "comments/edit"
    end

    it "should render update template on update action by ajax" do
      xhr :get, :update, { id: @comment, comment: { body: "new text" } }
      response.should render_template "comments/update"
    end

    it "should update comment on update action by ajax" do
      xhr :get, :update, { id: @comment, comment: { body: "new text" } }
      Comment.find(@comment.id).body.should_not be_eql "I'm a first comment"
    end

    it "should not update comment on update action by ajax with invalid comment's body" do
      xhr :get, :update, { id: @comment, comment: { body: "+1" } }
      Comment.find(@comment).body.should be_eql("I'm a first comment")
    end

    it "should render destroy template on destroy action by ajax" do
      xhr :get, :destroy, { id: @comment }
      response.should render_template "comments/destroy"
    end

    it "should delete the comment on destroy action by ajax" do
      xhr :get, :destroy, id: @comment
      Comment.exists?(@comment).should be_false
    end

    it "should render create template on create action by ajax" do
      xhr :get, :create, comment: { body: "I'm a Test comment"}, custom_news: @comment.custom_news
      response.should render_template "comments/create"
    end

    it "should create comment on create action by ajax" do
      comments_count = Comment.all.length
      xhr :get, :create, comment: { body: "I'm a Test comment"}, custom_news: @comment.custom_news
      comments_count.should_not be_eql Comment.all.length
    end

    it "can't create a comment if comment body is invalid on create action by ajax" do
      comments_count = Comment.all.length
      xhr :get, :create, comment: { body: "+1"}, custom_news: @comment.custom_news
      comments_count.should be_eql Comment.all.length
    end

    it "anyone can't remove stranger comment" do
      @stranger_user = User.create({
          email: 'user2@test.com',
          password: 'password',
          confirmed_at: Time.now,
          confirmation_sent_at: Time.now
                                   })
      @stranger_comment = Comment.create({
          body: "Another comment",
          custom_news: Factory(:custom_news),
          user: @stranger_user
                                         })
      xhr :get, :destroy, id: @stranger_comment
      Comment.exists?(@stranger_comment).should be_true
    end
  end

  describe "as signed out user" do
    it "should not render update template on update action by ajax" do
      xhr :get, :update, { id: @comment, comment: { body: "new text" } }
      response.should_not render_template "comments/update"
    end
  end
end