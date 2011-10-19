require 'spec_helper'

describe TwitterBlock do
  it "should be valid" do
    profile = Factory.build(:twitter_block)
    profile.should be_valid
  end

  it "should not be valid without search" do
    profile = Factory.build(:twitter_block, :search => "")
    profile.should have(1).error_on(:search)
  end
end
