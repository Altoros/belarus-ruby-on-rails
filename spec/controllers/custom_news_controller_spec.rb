require 'spec_helper'

describe CustomNewsController do
  before(:each) do
    sign_in user
  end

  context "when logged in as admin" do
    let(:user) { Factory(:user, :is_admin => true) }

    describe "#new" do
      before(:each) do
        get :new
      end

      it "assigns a new custom_news as @custom_news" do
        assigns(:custom_news).should be_a_new(CustomNews)
      end

      it "renders the 'new' template" do
        response.should render_template(:new)
      end
    end

    describe "#edit" do
      before(:each) do
        @custom_news = Factory(:custom_news)
        get :edit, :id => @custom_news.id
      end

      it "assigns the requested custom_news as @custom_news" do
        assigns(:custom_news).should eq(@custom_news)
      end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "#create" do
      before(:each) do
        post :create, :custom_news => attributes
      end

      context "with valid parameters" do
        let(:attributes) { Factory.attributes_for(:custom_news) }

        it "creates a new CustomNews" do
          CustomNews.all.should have(1).item
        end

        it "assigns a newly created custom_news as @custom_news" do
          assigns(:custom_news).should be_a(CustomNews)
          assigns(:custom_news).should be_persisted
        end

        it "redirects to the created custom_news" do
          response.should redirect_to(CustomNews.last)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { {} }

        it "assigns a newly created but unsaved custom_news as @custom_news" do
          assigns(:custom_news).should be_a_new(CustomNews)
        end

        it "re-renders the 'new' template" do
          response.should render_template(:new)
        end
      end
    end

    describe "#update" do
      before(:each) do
        @custom_news = Factory(:custom_news)
        put :update, :id => @custom_news.id, :custom_news => attributes
      end

      context "with valid parameters" do
        let(:attributes) do
          @title = "test_title"

          { :title => @title }
        end
        
        it "updates the requested custom_news" do
          @custom_news.reload

          @custom_news.title.should eq(@title)
        end

        it "assigns the requested custom_news as @custom_news" do
          assigns(:custom_news).should eq(@custom_news)
        end

        it "redirects to the custom_news" do
          response.should redirect_to(@custom_news)
        end
      end

      describe "with invalid parameters" do
        let(:attributes) { {:title => "" } }

        it "assigns the custom_news as @custom_news" do
          assigns(:custom_news).should eq(@custom_news)
        end

        it "re-renders the 'edit' template" do
          response.should render_template(:edit)
        end
      end
    end

    describe "#destroy" do
      before(:each) do
        @custom_news = Factory(:custom_news)
        delete :destroy, :id => @custom_news.id
      end

      it "destroys the requested custom_news" do
        CustomNews.all.should have(0).items
      end

      it "redirects to the custom_news list" do
        response.should redirect_to(custom_news_index_path)
      end
    end
  end

  context "when logged in as user" do
    let(:user) { Factory(:user) }

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
    let(:user) { User.new }

    describe "#index" do
      before(:each) do
        @custom_news = Factory(:custom_news)
        get :index
      end

      it "assigns all custom_news as @custom_news" do
        assigns(:custom_news).should eq([@custom_news])
      end

      it "renders the 'index' template" do
        response.should render_template(:index)
      end
    end

    describe "#show" do
      before(:each) do
        @custom_news = Factory(:custom_news)
        get :show, :id => @custom_news.id
      end

      it "assigns the requested custom_news as @custom_news" do
        assigns(:custom_news).should eq(@custom_news)
      end

      it "renders the 'show' template" do
        response.should render_template(:show)
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
