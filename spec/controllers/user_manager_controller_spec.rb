require 'spec_helper'

describe UserManagerController do

  describe "For anonymous user" do
    it "should not show user list" do
      get 'index'
      response.should_not be_success
    end

    it "should not change admin rights" do
      get 'change_admin_state'
      response.should_not be_success
    end
  end

  describe "For admins" do
    it "should show user list" do
      @user = Factory :user
      @user.change_admin_state!
      sign_in @user
      get 'index'
      response.should be_success
    end

    it "should change admins" do
      @user = Factory :user
      @user.change_admin_state!
      sign_in @user
      user = User.new(email: "user@example.com", password: "password", password_confirmation: "password")
      user.save
      get 'change_admin_state', { id: user.id }
      (User.find user.id).is_admin?.should be_true
    end
  end
end
