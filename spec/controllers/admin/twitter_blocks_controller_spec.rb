require 'spec_helper'

describe Admin::TwitterBlocksController do
  before(:each) do
    sign_in sign_in_user
  end

  context "when logged in as admin" do
    let(:sign_in_user) { Factory(:user, :is_admin => true) }

    describe "#new" do
      before(:each) do
        get :new
      end

      it "assigns a new twitter_block as @twitter_block" do
        assigns(:twitter_block).should be_a_new(TwitterBlock)
      end

      it "renders the 'new' template" do
        response.should render_template(:new)
      end
    end

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

    describe "#create" do
      before(:each) do
        post :create, :twitter_block => attributes
      end

      context "with valid parameters" do
        let(:attributes) { Factory.attributes_for(:twitter_block) }

        it "creates a new TwitterBlock" do
          TwitterBlock.all.should have_at_least(1).item
        end

        it "assigns a newly created twitter_block as @twitter_block" do
          assigns(:twitter_block).should be_a(TwitterBlock)
          assigns(:twitter_block).should be_persisted
        end

        it "redirects to the created twitter_block" do
          response.should redirect_to(edit_admin_twitter_block_path(TwitterBlock.last))
        end
      end

      context "with invalid parameters" do
        let(:attributes) { {} }

        it "assigns a newly created but unsaved twitter_block as @twitter_block" do
          assigns(:twitter_block).should be_a_new(TwitterBlock)
        end

        it "re-renders the 'new' template" do
          response.should render_template(:new)
        end
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

        it "updates the requested twitter_block" do
          @twitter_block.reload

          @twitter_block.search.should eq(@search)
        end

        it "assigns the requested twitter_block as @twitter_block" do
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

    describe "#destroy" do
      before(:each) do
        @twitter_block = Factory(:twitter_block)
        delete :destroy, :id => @twitter_block.id
      end

      it "destroys the requested twitter block" do
        TwitterBlock.find_by_id(@twitter_block.id).should be_nil
      end

      it "redirects to the twitter blocks list" do
        response.should redirect_to(admin_twitter_blocks_path)
      end
    end
  end

  context "when logged in as user" do
    let(:sign_in_user) { Factory(:user) }

    describe "#new" do
      it "is forbidden" do
        get :new
        response.status.should eq(403)
      end
    end

    describe "#create" do
      it "is forbidden" do
        post :create
        response.status.should eq(403)
      end
    end

    describe "#edit" do
      it "is forbidden" do
        get :edit
        response.status.should eq(403)
      end
    end

    describe "#update" do
      it "is forbidden" do
        post :update
        response.status.should eq(403)
      end
    end

    describe "#destroy" do
      it "is forbidden" do
        delete :destroy
        response.status.should eq(403)
      end
    end
  end

  context "when not logged in" do
    let(:sign_in_user) { User.new }

    describe "#index" do
      it "redirects to login page" do
        get :index
        response.should redirect_to(login_path)
      end
    end

    describe "#new" do
      it "redirects to login page" do
        get :new
        response.should redirect_to(login_path)
      end
    end

    describe "#create" do
      it "redirects to login page" do
        post :create
        response.should redirect_to(login_path)
      end
    end

    describe "#edit" do
      it "redirects to login page" do
        get :edit
        response.should redirect_to(login_path)
      end
    end

    describe "#update" do
      it "redirects to login page" do
        post :update
        response.should redirect_to(login_path)
      end
    end

    describe "#destroy" do
      it "redirects to login page" do
        delete :destroy
        response.should redirect_to(login_path)
      end
    end
  end
end
