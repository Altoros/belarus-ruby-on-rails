require 'spec_helper'

module AgregatedArticleSpecHelper
  def valid_agregated_article_attributes
    Factory.attributes_for(:agregated_article)
  end
end

describe AgregatedArticle do

  include AgregatedArticleSpecHelper

  before(:each) do
    @article = AgregatedArticle.new
  end

  it "should be valid" do
    @article.attributes = valid_agregated_article_attributes
    @article.should be_valid
  end

  it "should should not be valid without something to attach to" do
    c = valid_agregated_article_attributes
    c.delete :title
    c.delete :rss_link
    c.delete :content
    @article.attributes = c
    @article.should_not be_valid
    @article.error_on(:title).should eql(["can't be blank"])
    @article.title = 'Some title'
    @article.should_not be_valid
    @article.error_on(:rss_link).should eql(["can't be blank"])
    @article.rss_link = 'Some link'
    @article.should_not be_valid
    @article.error_on(:content).should eql(["can't be blank"])
    @article.content = "Some text"
    @article.should be_valid
  end

end
