require 'spec_helper'

describe UsersController do

  describe "For anonymous user" do
    it "should not reset user password" do
      user = Factory(:user)
      get 'reset_password', {:id => user.id }
      User.find(user.id).reset_password_token.should be_nil
    end

  end

  describe "For registered and logged in user" do
    let(:registered_user) { Factory(:user) }
    before(:each) do
      sign_in registered_user
    end

    it "should not reset user password" do
      user = Factory(:user)
      get 'reset_password', {:id => user.id }
      User.find(user.id).reset_password_token.should be_nil
    end

  end

  describe "For admins" do
    let(:admin) { Factory(:user, :is_admin => true) }
    before(:each) do
      sign_in admin
    end

    it "should reset user password" do
      user = Factory(:user)
      get 'reset_password', {:id => user.id }
      User.find(user.id).reset_password_token.should_not be_nil
    end

  end
end
