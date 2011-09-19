require 'spec_helper'

describe UsersController do

  before (:each) do
    @user = Factory(:user)
    sign_in @user
    get :show, :id => @user.id
  end

  describe "GET 'show'" do
    it "should be successful" do
      response.should be_success
    end

    it "should find the right user" do
      assigns(:user).should == @user
    end
  end

end
