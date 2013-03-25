require 'spec_helper'

describe Article do
  subject{ FactoryGirl.build(:article, :user => FactoryGirl.create(:user)) }
  it { should be_valid }

  it "is not valid if title is empty" do
    article = FactoryGirl.build(:article, :title => nil)
    article.should_not be_valid
  end

  it "is not valid if title is too long" do
    str = "a" * 257
    article = FactoryGirl.build(:article, :title => str)
    article.should_not be_valid
  end

  it "is not valid if content is empty" do
    article = FactoryGirl.build(:article, :content => nil)
    article.should_not be_valid
  end
end