require 'spec_helper'

describe ArticlesController do
  before(:each) do
    sign_in user
  end

  context "when not logged in" do
    let(:user) { User.new }

    describe "#index" do
      before(:each) do
        @articles = FactoryGirl.create(:article)
        get :index
      end

      it "assigns all articles as @articles" do
        assigns(:articles).should eq([@articles])
      end

      it "renders the 'index' template" do
        response.should render_template(:index)
      end
    end

    describe "#show" do
      context 'with integer ID' do
        before(:each) do
          @article = FactoryGirl.create(:article)
          get :show, :id => @article.id
        end

        it "assigns the requested article as @article" do
          assigns(:article).should eq(@article)
        end

        it "renders the 'show' template" do
          response.should render_template(:show)
        end
      end

      context "with word's alias ID" do
        before(:each) do
          @article = FactoryGirl.create(:article)
          get :show, :id => @article.slug
        end

        it "assigns the requested article as @article" do
          assigns(:article).should eq(@article)
        end

        it "renders the 'show' template" do
          response.should render_template(:show)
        end
      end
    end
  end
end
