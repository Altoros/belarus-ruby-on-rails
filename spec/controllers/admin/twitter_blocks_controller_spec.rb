require 'spec_helper'

describe Admin::TwitterBlocksController do
  before(:each) do
    sign_in sign_in_user
  end

  context "when logged in as admin" do
    let(:sign_in_user) { Factory(:user, :is_admin => true) }

    describe "#edit" do
      before(:each) do
        @twitter_block = Factory(:twitter_block)
        get :edit, :id => @twitter_block.id
      end

      it "assigns the requested twitter_block as @twitter_block" do
        assigns(:twitter_block).should eq(@twitter_block)
      end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "#update" do
      before(:each) do
        @twitter_block = Factory(:twitter_block)
        put :update, :id => @twitter_block.id, :twitter_block => attributes
      end

      context "with valid parameters" do
        let(:attributes) do
          @search = "MyString"

          { :search => @search }
        end

        it "updates the requested article" do
          @twitter_block.reload

          @twitter_block.search.should eq(@search)
        end

        it "assigns the requested article as @article" do
          assigns(:twitter_block).should eq(@twitter_block)
        end

        it "redirects to the twitter_block" do
          response.should redirect_to(edit_admin_twitter_block_path(@twitter_block))
        end
      end

      describe "with invalid parameters" do
        let(:attributes) { {:search => "" } }

        it "assigns the twitter_block as @twitter_block" do
          assigns(:twitter_block).should eq(@twitter_block)
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
