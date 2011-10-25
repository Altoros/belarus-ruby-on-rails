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
    let(:admin) { Factory(:user, :is_admin => true) }
    before(:each) do
      sign_in admin
    end

    it "should show user list" do
      get 'index'
      response.should be_success
    end

    it "should change admins" do
      user = Factory(:user)
      put 'update', { :id => user.id, :attr => 'admin' }
      User.find(user.id).is_admin?.should be_true
    end

    it "should change ban state" do
      user = Factory(:user)
      put 'update', { :id => user.id, :attr => 'banned' }
      User.find(user.id).banned?.should be_true
    end
  end
end
