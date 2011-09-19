require 'spec_helper'

module ProfileSpecHelper
  def valid_profile_attributes
    Factory.attributes_for(:profile)
  end
end

describe Profile do

  include ProfileSpecHelper

  before(:each) do
    @user = User.new
    @user.profile = Profile.new
  end

  it "should be valid" do
    @user.profile.attributes = valid_profile_attributes
    @user.profile.should be_valid
  end

  it "should not be valid without required fields" do
    c = valid_profile_attributes
    c.delete :first_name
    c.delete :last_name
    @user.profile.attributes = c
    @user.profile.should_not be_valid
    @user.profile.error_on(:first_name).should eql(["can't be blank"])
    @user.profile.first_name = valid_profile_attributes[:first_name]
    @user.profile.should_not be_valid
    @user.profile.error_on(:last_name).should eql(["can't be blank"])
    @user.profile.last_name = valid_profile_attributes[:last_name]
    @user.profile.should be_valid
  end

end
