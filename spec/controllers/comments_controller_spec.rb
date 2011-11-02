require 'spec_helper'

describe CommentsController do
  render_views

  def parseResponseJSON
    response.header['Content-Type'].should include('application/json')
    ActiveSupport::JSON.decode(response.body)
  end

  before :each do
    @comment = Factory(:comment, :article_id => Factory(:article).id, :user => Factory(:user))
  end
  let(:new_comment_body) { 'example of editing comment' }

  describe  "as signed in user" do

    before :each do
      sign_in @comment.user
    end

    describe '#edit' do
      it "should contain comment's form on edit action" do
        xhr :get, :edit, { :id => @comment, :format => :json }
        json = parseResponseJSON

        json['form_html'].should_not be_nil
        json['form_html'].should have_selector('form')
      end
    end


    describe '#update' do
      it "should updated comment" do
        xhr :post, :update, { :id => @comment, :comment => { :body => new_comment_body }, :format => :json }
        json = parseResponseJSON

        json['content_html'].should_not be_nil
        json['content_html'].should_not have_selector('form')
        json['content_html'].should have_content(new_comment_body)
      end

      it "should not update comment with invalid body" do
        xhr :post, :update, { :id => @comment, :comment => { :body => '**' }, :format => :json }
        json = parseResponseJSON

        json['content_html'].should_not be_nil
        json['content_html'].should have_selector('form')
        json['content_html'].should have_selector('div.error')
      end

      it "should can't update article binding" do
        stranger_article = Factory :article
        original_article_id = @comment.article_id
        xhr :post, :update, { :id => @comment, :comment => { :body => new_comment_body, :article_id => stranger_article }, :format => :json }
        json = parseResponseJSON

        json['content_html'].should_not be_nil

        Comment.find(@comment.id).article_id.should eq(original_article_id)
      end

      it "should can't update owner of comment" do
        stranger_user = Factory(:user, :email => "user2@test.com")
        original_owner_id = @comment.user_id
        xhr :post, :update, { :id => @comment, :comment => { :body => new_comment_body, :user_id => stranger_user }, :format => :json }
        json = parseResponseJSON

        json['content_html'].should_not be_nil

        Comment.find(@comment.id).user_id.should eq(original_owner_id)
      end
    end

    describe '#delete' do
      it "should response with div_id of deleted comment" do
        xhr :get, :destroy, { :id => @comment }
        json = parseResponseJSON

        json['comment_div_id'].should_not be_nil
        json['comment_div_id'].should eq("comment_#{ @comment.id }")
      end

      it "should delete the comment" do
        xhr :get, :destroy, { :id => @comment }
        json = parseResponseJSON

        json['comment_div_id'].should_not be_nil
        Comment.exists?(@comment).should be_false
      end

      it "should have no access to remove foreign comment" do
        @stranger_user = Factory(:user, :email => "user2@test.com")
        @stranger_comment = Factory(:comment, :article_id => Factory(:article).id, :user => @stranger_user)
        xhr :get, :destroy, { :id => @stranger_comment }

        response.status.should eq(403)
      end
    end

    describe '#create' do
      it "should create comment" do
        xhr :post, :create, { :comment => { :body => new_comment_body }, :article_id => @comment.article, :format => :json }
        json = parseResponseJSON

        json['create_status'].should be_true
        json['comment_html'].should_not be_nil
        json['comment_html'].should have_content(new_comment_body)
      end


      it "can't create a comment with invalid comment body" do
        xhr :post, :create, :comment => { :body => '**' }, :article_id => @comment.article
        json = parseResponseJSON

        json['create_status'].should be_false
        json['comment_html'].should be_nil
      end

      it "can't create a comment with invalid article" do
        lambda {
          xhr :post, :create, :comment => { :body => new_comment_body }, :article_id => '42'
        }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'banned user' do
      before(:each) do
        @comment.user.change_banned_state!
      end

      it 'should not has access to create comment' do
        xhr :get, :create, :comment => { :body => "I'm a Test comment"}, :article_id => @comment.article.id
        response.status.should eq 403
      end

      it 'should not has access to edit comment' do
        xhr :get, :update, :id => @comment, :comment => { :body => "I'm updated comment" }, :article_id => @comment.article.id
        response.status.should eq 403
      end

      it 'should not has access to remove comment' do
        xhr :get, :destroy, :id => @comment
        response.status.should eq 403
      end
    end
  end

  describe "as signed out user" do
    it "should not render update template on update action by ajax" do
      xhr :get, :update, { :id => @comment, :comment => { :body => "new text" }, :article_id => @comment.article_id }
      response.should_not render_template "comments/update"
    end
  end

  context 'email notification' do
    before(:each) do
      ActionMailer::Base.deliveries = []
      @article = Factory :article
      @user_subscribed = Factory(:user, :profile => Factory(:profile,
                                                :subscribed => true,
                                                :subscribed_for_comments => true,
                                                :experience => Factory(:experience)))
      @user_unsubscribed = Factory(:user, :profile => Factory(:profile,
                                                :experience => Factory(:experience)))
      sign_in @user_subscribed
      xhr :post, :create, { :article_id => @article.id, :comment => { :body => 'Example comment'} }
      sign_out @user_subscribed

      sign_in @user_unsubscribed
      xhr :post, :create, { :article_id => @article.id, :comment => { :body => 'Example comment'} }
      sign_out @user_unsubscribed

      sign_in @user_subscribed
      xhr :post, :create, { :article_id => @article.id, :comment => { :body => 'Example comment'} }
      sign_out @user_subscribed

      Delayed::Worker.new.work_off
    end

    it "messages was sent" do
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "send message to subscibed user" do
      ActionMailer::Base.deliveries.last.to.should eq([@user_subscribed.email])
    end

    it "don't send message to usubscibed user" do
      ActionMailer::Base.deliveries.collect{ |el| el.to }.should_not include([@user_unsubscribed.email])
    end
  end
end
