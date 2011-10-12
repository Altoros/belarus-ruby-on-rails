require 'spec_helper'

describe Profile do
  it "should be valid" do
    profile = Factory.build(:profile)
    profile.should be_valid
  end

  it "should not be valid without first name" do
    profile = Factory.build(:profile, :first_name => "")
    profile.should have(1).error_on(:first_name)
  end

  it "should not be valid without last name" do
    profile = Factory.build(:profile, :last_name => "")
    profile.should have(1).error_on(:last_name)
  end

  it "should not be valid if first name is longer than 255 symbols" do
    profile = Factory.build(:profile, :first_name => "a" * 256)
    profile.should have(1).error_on(:first_name)
  end

  it "should not be valid if last name is longer than 255 symbols" do
    profile = Factory.build(:profile, :last_name => "a" * 256)
    profile.should have(1).error_on(:last_name)
  end

  it { should respond_to(:subscribed) }

  it "has a Ruby experience level" do
    profile = Factory(:profile, :subscribed => true, :experience => Factory(:experience))
    profile.experience.should_not be_nil
  end

  it "should set Ruby on Rails experience level if subscribed" do
    profile = Factory.build(:profile, :experience => nil)
    profile.should have(1).error_on(:experience_id)
  end
end
