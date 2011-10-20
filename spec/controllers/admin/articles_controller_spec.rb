require 'spec_helper'

describe Admin::ArticlesController do
  before(:each) do
    sign_in user
  end

  context "when logged in as admin" do
    let(:user) { Factory(:user, :is_admin => true) }

    describe "#new" do
      before(:each) do
        get :new
      end

      it "assigns a new article as @article" do
        assigns(:article).should be_a_new(Article)
      end

      it "renders the 'new' template" do
        response.should render_template(:new)
      end
    end

    describe "#edit" do
      before(:each) do
        @article = Factory(:article)
        get :edit, :id => @article.id
      end

      it "assigns the requested article as @article" do
        assigns(:article).should eq(@article)
      end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "#create" do
      before(:each) do
        post :create, :article => attributes
      end

      context "with valid parameters" do
        let(:attributes) { Factory.attributes_for(:article) }

        it "creates a new Article" do
          Article.all.should have(1).item
        end

        it "assigns a newly created article as @article" do
          assigns(:article).should be_a(Article)
          assigns(:article).should be_persisted
        end

        it "redirects to the articles list in admin control panel" do
          response.should redirect_to(admin_articles_path)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { {} }

        it "assigns a newly created but unsaved article as @article" do
          assigns(:article).should be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          response.should render_template(:new)
        end
      end
    end

    describe "#update" do
      before(:each) do
        @article = Factory(:article)
        put :update, :id => @article.id, :article => attributes
      end

      context "with valid parameters" do
        let(:attributes) do
          @title = "test_title"
          { :title => @title }
        end

        it "updates the requested article" do
          @article.reload
          @article.title.should eq(@title)
        end

        it "assigns the requested article as @article" do
          assigns(:article).should eq(@article)
        end

        it "redirects to the article" do
          @article.reload
          response.should redirect_to(edit_admin_article_path(@article))
        end
      end

      describe "with invalid parameters" do
        let(:attributes) { {:title => "" } }

        it "assigns the article as @article" do
          assigns(:article).should eq(@article)
        end

        it "re-renders the 'edit' template" do
          response.should render_template(:edit)
        end
      end
    end

    describe "#destroy" do
      before(:each) do
        @article = Factory(:article)
        delete :destroy, :id => @article.id
      end

      it "destroys the requested article" do
        Article.all.should have(0).items
      end

      it "redirects to the articles list" do
        response.should redirect_to(admin_articles_path)
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
