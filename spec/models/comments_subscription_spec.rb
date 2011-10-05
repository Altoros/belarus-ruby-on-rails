require 'spec_helper'

describe CommentsSubscription do

  before(:each) do
    @comments_subscription = CommentsSubscription.new(:profile_id => '1', :article_id => '1')
    @comments_subscription.save
  end

  it "should not be valid if unique combinations of profile and article used" do
    @comments_subscription = CommentsSubscription.new(:profile_id => '1', :article_id => '1')
    @comments_subscription.should_not be_valid
  end

  it "should be valid if different combinations of profile and article used" do
    @comments_subscription = CommentsSubscription.new(:profile_id => '1', :article_id => '2')
    @comments_subscription.should be_valid
  end
end
