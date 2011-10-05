require 'spec_helper'

module ArticleSpecHelper
  def valid_article_attributes
    { :title => 'Some title',
      :content => 'Some text',
      :published => true }
  end
end

describe Article do

  include ArticleSpecHelper

  before(:each) do
    @article = Article.new
  end

  it "should be valid" do
    @article.attributes = valid_article_attributes
    @article.should be_valid
  end

  it "should should not be valid without something to attach to" do
    c = valid_article_attributes
    c.delete :title
    c.delete :content
    @article.attributes = c
    @article.should_not be_valid
    @article.error_on(:title).should eql(["can't be blank"])
    @article.title = 'Some title'
    @article.should_not be_valid
    @article.error_on(:content).should eql(["can't be blank"])
    @article.content = "Some text"
    @article.should be_valid
  end

end
