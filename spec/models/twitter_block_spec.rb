require 'spec_helper'

describe TwitterBlock do
  it "should be valid" do
    twitter_block = Factory.build(:twitter_block)
    twitter_block.should be_valid
  end

  it "should not be valid without search" do
    twitter_block = Factory.build(:twitter_block, :search => "")
    twitter_block.should have(1).error_on(:search)
  end
end
