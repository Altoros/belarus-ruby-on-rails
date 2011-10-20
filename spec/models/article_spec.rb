require 'spec_helper'

describe Article do
  subject{ Factory.build(:article, :user => Factory(:user)) }
  it { should be_valid }

  it "is not valid if fake user" do
    article = Factory.build(:article, :user => nil)
    article.should_not be_valid
  end

  it "is not valid if title is empty" do
    article = Factory.build(:article, :title => nil)
    article.should_not be_valid
  end

  it "is not valid if title is too long" do
    str = "a" * 257
    article = Factory.build(:article, :title => str)
    article.should_not be_valid
  end

  it "is not valid if content is empty" do
    article = Factory.build(:article, :content => nil)
    article.should_not be_valid
  end
end