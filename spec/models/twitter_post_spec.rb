require 'spec_helper'

describe TwitterPost do
  it "should be valid" do
    profile = Factory.build(:twitter_post)
    profile.should be_valid
  end

  it "should not be valid without search" do
    profile = Factory.build(:twitter_post, :search => "")
    profile.should have(1).error_on(:search)
  end
end
