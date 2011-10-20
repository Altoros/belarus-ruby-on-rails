require 'spec_helper'

describe Article do
  subject{ Factory.build(:article, :user => Factory(:user)) }
  it { should be_valid }

  it "is not valid if fake user or empty title" do
    article = Factory.build(:article, :user => nil, :title => nil)
    article.should_not be_valid
  end
end