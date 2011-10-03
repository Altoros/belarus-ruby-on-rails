require 'spec_helper'

describe Comment do
  before :each do
    @comment = Comment.new
  end

  it "comment's body should not be nil" do
    @comment.body = nil
    @comment.should_not be_valid
    @comment.error_on(:body).should_not be_nil
  end

  it "length of comment's body should be valid" do
    @comment.body = ""
    @comment.should_not be_valid
  end

  it "parent article should be" do
    @comment.article = nil
    @comment.should_not be_valid
  end
end
