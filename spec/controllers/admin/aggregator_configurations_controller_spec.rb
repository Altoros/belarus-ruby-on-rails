require 'spec_helper'

describe Admin::AggregatorConfigurationsController do
  before(:each) do
    sign_in sign_in_user
  end

  context "when logged in as admin" do
    let(:sign_in_user) { Factory(:user, :is_admin => true) }

    describe "#edit" do
      before(:each) do
        @aggregator_configuration = Factory(:aggregator_configuration)
        get :edit, :id => @aggregator_configuration.id
      end

      it "assigns the requested aggregator_configuration as @aggregator_configuration" do
        assigns(:aggregator_configuration).should eq(@aggregator_configuration)
      end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "#create" do
      before(:each) do
        post :create, :aggregator_configuration => attributes
      end

      context "with valid parameters" do
        let(:attributes) { Factory.attributes_for(:aggregator_configuration) }

        it "creates a new AggregatorConfiguration" do
          AggregatorConfiguration.all.should have_at_least(1).item
        end

        it "assigns a newly created aggregator_configuration as @aggregator_configuration" do
          assigns(:aggregator_configuration).should be_a(AggregatorConfiguration)
          assigns(:aggregator_configuration).should be_persisted
        end

        it "redirects to the created aggregator_configuration" do
          response.should redirect_to(admin_root_path)
        end
      end

      context "with invalid parameters" do
        let(:attributes) { {} }

        it "assigns a newly created but unsaved aggregator_configuration as @aggregator_configuration" do
          assigns(:aggregator_configuration).should be_a_new(AggregatorConfiguration)
        end

        it "re-renders the 'edit' template" do
          response.should render_template(:edit)
        end
      end
    end

    describe "#update" do
      before(:each) do
        @aggregator_configuration = Factory(:aggregator_configuration)
        put :update, :id => @aggregator_configuration.id, :aggregator_configuration => attributes
      end

      context "with valid parameters" do
        let(:attributes) do
          @source = "MyString"

          { :source => @source }
        end

        it "updates the requested aggregator_configuration" do
          @aggregator_configuration.reload

          @aggregator_configuration.source.should eq(@source)
        end

        it "assigns the requested aggregator_configuration as @aggregator_configuration" do
          assigns(:aggregator_configuration).should eq(@aggregator_configuration)
        end

        it "redirects to the aggregator_configuration" do
          response.should redirect_to(admin_root_path)
        end
      end

      describe "with invalid parameters" do
        let(:attributes) { {:source => "" } }

        it "assigns the aggregator_configuration as @aggregator_configuration" do
          assigns(:aggregator_configuration).should eq(@aggregator_configuration)
        end

        it "re-renders the 'edit' template" do
          response.should render_template(:edit)
        end
      end
    end

  end

  context "when logged in as user" do
    let(:sign_in_user) { Factory(:user) }

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

  end

  context "when not logged in" do
    let(:sign_in_user) { User.new }

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

  end
end
