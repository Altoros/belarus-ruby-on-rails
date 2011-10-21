require 'spec_helper'

describe ProfilesController do
  before(:each) do
    sign_in sign_in_user
  end

  context "when logged in as admin" do
    let(:sign_in_user) { Factory(:user, :is_admin => true) }

    describe "#edit" do
      before(:each) do
        @user = Factory(:user)
        get :edit, :id => @user.profile.id
      end

      it "assigns the requested profile as @profile" do
        assigns(:profile).should eq(@user.profile)
      end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "#update" do
      before(:each) do
        @user = Factory(:user)
        put :update, :id => @user.profile.id, :profile => attributes
      end

      context "with valid params" do
        let(:attributes) { { :first_name => @first_name = "test" } }

        it "updates the requested profile" do
          @user.profile.reload
          @user.profile.first_name.should eq(@first_name)
        end

        it "assigns the requested profile as @profile" do
          assigns(:profile).should eq(@user.profile)
        end

        it "redirects to the profile" do
          response.should redirect_to(@user.profile)
        end
      end

      context "with invalid params" do
        let(:attributes) { { :first_name => "" } }

        it "assigns the profile as @profile" do
          assigns(:profile).should eq(@user.profile)
        end

        it "re-renders the 'edit' template" do
          response.should render_template("edit")
        end
      end
    end
  end

  context "when logged in as user" do
    let(:sign_in_user) { Factory(:user) }

    describe "#show" do
      before(:each) do
        @user = sign_in_user
        get :show, :id => @user.profile.id
      end

      it "assigns the requested profile as @profile" do
        assigns(:profile).should eq(@user.profile)
      end

      it "renders the 'show' template" do
        response.should render_template(:show)
      end
    end

    describe "#edit" do
      context "when profile belongs to user" do
        before(:each) do
          @user = sign_in_user
          get :edit, :id => @user.profile.id
        end

        it "assigns the requested profile as @profile" do
          assigns(:profile).should eq(@user.profile)
        end

        it "renders the 'edit' template" do
          response.should render_template(:edit)
        end
      end

      context "when profile belongs to another user" do
        it "is forbidden" do
          user = Factory(:user)
          get :edit, :id => user.profile.id

          response.status.should eq(403)
        end
      end
    end

    describe "#update" do
      before(:each) do
        @user = sign_in_user
        put :update, :id => @user.profile.id, :profile => attributes
      end

      context "with valid params" do
        let(:attributes) { { :first_name => @first_name = "test",
                             :avatar => Rack::Test::UploadedFile.new("spec/fixtures/files/upic_default.jpg", 'image/jpg') } }

        it "updates the requested profile" do
          @user.profile.reload
          @user.profile.first_name.should eq(@first_name)
          @user.profile.avatar.exists?.should be_true
        end

        it "assigns the requested profile as @profile" do
          assigns(:profile).should eq(@user.profile)
        end

        it "redirects to the profile" do
          response.should redirect_to(@user.profile)
        end
      end

      context "with invalid params" do
        let(:attributes) { { :first_name => "" } }

        it "assigns the profile as @profile" do
          assigns(:profile).should eq(@user.profile)
        end

        it "re-renders the 'edit' template" do
          response.should render_template("edit")
        end
      end
    end

    describe "#avatar" do
      before(:each) do
        @user = Factory(:user, :profile => Factory(:profile_with_upic))
        sign_in @user
      end

      context 'on own profile' do
        before(:each) do
          xhr :delete, :avatar, :id => @user.profile.id
        end

        it 'delete avatar' do
          @user.profile.avatar.exists?.should be_false
        end
      end

      context 'on foreigner profile' do
        before(:each) do
          @another_user = Factory(:user, :profile => Factory(:profile_with_upic))
          xhr :delete, :avatar, :id => @another_user.profile.id
        end

        it "don't delete avatar" do
          @another_user.profile.avatar.exists?.should be_true
        end
      end
    end
  end

  context "when not logged in" do
    let(:sign_in_user) { User.new }

    before(:each) do
      @user = Factory(:user)
    end

    describe "#show" do
      it "redirects to login path" do
        get :show, :id => @user.profile.id
        response.should redirect_to(login_path)
      end
    end

    describe "#edit" do
      it "redirects to login path" do
        get :edit, :id => @user.profile.id
        response.should redirect_to(login_path)
      end
    end

    describe "#update" do
      it "redirects to login path" do
        post :update, :id => @user.profile.id
        response.should redirect_to(login_path)
      end
    end
  end
end
