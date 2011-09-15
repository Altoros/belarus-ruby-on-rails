require 'spec_helper'

describe Comment do
  before :each do
    @comment = Comment.new
  end

  it "comment's body should not be nil" do
    @comment.body = nil
    @comment.should_not be_valid
  end

  it "length of comment's body should be valid" do
    @comment.body = ""
    @comment.should_not be_valid
  end

  it "parent custom news should be" do
    @comment.custom_news = nil
    @comment.user = Factory :user
    @comment.should_not be_valid
  end

  it "should have user" do
    @comment.user = nil
    @comment.custom_news = Factory :custom_news
    @comment.should_not be_valid
  end

  it "should be ok on valid properties" do
    @comment.body = "I'm a comment"
    @comment.user = Factory :user
    @comment.custom_news = Factory :custom_news
    @comment.should be_valid
  end
end
