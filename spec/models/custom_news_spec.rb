require 'spec_helper'

module CustomNewsSpecHelper
  def valid_custom_news_attributes
    { :title => 'Some title',
      :content => 'Some text',
      :status => 1 }
  end
end

describe CustomNews do

  include CustomNewsSpecHelper

  before(:each) do
    @custom_news = CustomNews.new
  end

  it "should be valid" do
    @custom_news.attributes = valid_custom_news_attributes
    @custom_news.should be_valid
  end

  it "should should not be valid without something to attach to" do
    c = valid_custom_news_attributes
    c.delete :title
    c.delete :content
    @custom_news.attributes = c
    @custom_news.should_not be_valid
    @custom_news.error_on(:title).should eql(["can't be blank"])
    @custom_news.title = 'Some title'
    @custom_news.should_not be_valid
    @custom_news.error_on(:content).should eql(["can't be blank"])
    @custom_news.content = "Some text"
    @custom_news.should be_valid
  end

end
