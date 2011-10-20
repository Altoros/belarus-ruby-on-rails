require 'spec_helper'

describe Admin::AggregatedArticlesController do
  before(:each) do
    sign_in user
  end

  context "when logged in as admin" do
    let(:user) { Factory(:user, :is_admin => true) }

    describe "#index" do
      before(:each) do
        @articles = Factory(:aggregated_article)
        get :index
      end

      it "assigns all aggregated articles as @articles" do
        assigns(:articles).should eq([@articles])
      end

      it "renders the 'index' template" do
        response.should render_template(:index)
      end
    end

    describe "#destroy" do
      before(:each) do
        @article = Factory(:aggregated_article)
        delete :destroy, :id => @article.id
      end

      it "destroys the requested article" do
        Article.all.should have(0).items
      end

      it "redirects to the articles list" do
        response.should redirect_to(admin_aggregated_articles_path)
      end
    end
  end

  context "when logged in as user" do
    let(:user) { Factory(:user) }

    describe "#index" do
      it "is forbidden" do
        get :index
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

    describe "#destroy" do
      it "redirects to login page" do
        delete :destroy
        response.should redirect_to(login_path)
      end
    end
  end
end
