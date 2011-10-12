require 'spec_helper'

describe Admin::UsersController do

  describe "For anonymous user" do
    it "should not show user list" do
      get 'index'
      response.should_not be_success
    end

    it "should not change admin rights" do
      put 'update'
      response.should_not be_success
    end
  end

  describe "For admins" do
    it "should show user list" do
      @user = Factory(:user, :is_admin => true)
      sign_in @user
      get 'index'
      response.should be_success
    end

    it "should change admins" do
      @user = Factory(:user, :is_admin => true)
      sign_in @user
      user = Factory(:user)
      put 'update', { :id => user.id }
      User.find(user.id).is_admin?.should be_true
    end
  end
end
