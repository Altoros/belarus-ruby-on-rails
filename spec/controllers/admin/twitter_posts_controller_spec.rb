require 'spec_helper'

describe Admin::TwitterPostsController do
  before(:each) do
    sign_in sign_in_user
  end

  context "when logged in as admin" do
    let(:sign_in_user) { Factory(:user, :is_admin => true) }

    describe "#edit" do
      before(:each) do
        @twitter_post = Factory(:twitter_post)
        get :edit, :id => @twitter_post.id
      end

      it "assigns the requested twitter_post as @twitter_post" do
        assigns(:twitter_post).should eq(@twitter_post)
      end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "#update" do
      before(:each) do
        @twitter_post = Factory(:twitter_post)
        put :update, :id => @twitter_post.id, :twitter_post => attributes
      end

      context "with valid parameters" do
        let(:attributes) do
          @search = "MyString"

          { :search => @search }
        end

        it "updates the requested article" do
          @twitter_post.reload

          @twitter_post.search.should eq(@search)
        end

        it "assigns the requested article as @article" do
          assigns(:twitter_post).should eq(@twitter_post)
        end

        it "redirects to the twitter_post" do
          response.should redirect_to(edit_admin_twitter_post_path(@twitter_post))
        end
      end

      describe "with invalid parameters" do
        let(:attributes) { {:search => "" } }

        it "assigns the twitter_post as @twitter_post" do
          assigns(:twitter_post).should eq(@twitter_post)
        end

        it "re-renders the 'edit' template" do
          response.should render_template(:edit)
        end
      end
    end
  end

  context "when logged in as user" do
    let(:sign_in_user) { Factory(:user) }

    describe "#edit" do
      before(:each) do
        get :edit
      end

      it "is forbidden" do
        response.status.should eq(403)
      end
    end

    describe "#update" do
      before(:each) do
        post :update
      end

      it "is forbidden" do
        response.status.should eq(403)
      end
    end
  end

  context "when not logged in" do
    let(:sign_in_user) { User.new }

    describe "#edit" do
      before(:each) do
        get :edit
      end

      it "redirects to the login page" do
        response.should redirect_to login_url
      end
    end

    describe "#update" do
      before(:each) do
        post :update
      end

      it "redirects to the login page" do
        response.should redirect_to login_url
      end
    end
  end
end
