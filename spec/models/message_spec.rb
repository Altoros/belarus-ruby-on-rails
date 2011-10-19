require 'spec_helper'

describe Message do
  subject { Message.new }

  it { should respond_to(:subject) }
  it { should respond_to(:body) }
  it { should have_at_least(1).error_on(:subject) }
  it { should have_at_least(1).error_on(:body) }

  it "is not valid if fake recipient group" do
    message = Factory.build(:message, :recipient_group => ['42'])
    message.should have_at_least(1).error_on(:recipient_group)
  end

  it "is valid if existing meetup filter" do
    meetup = Factory :meetup
    message = Factory.build(:message, :recipient_group => [meetup.id.to_s])
    message.should be_valid
  end

  it "is not valid if subject is longer than 100 symbols" do
    message = Factory.build(:message, :subject => 'a' * 102 )
    message.should have_at_least(1).error_on(:subject)
  end

  it "is not valid if body is longer than 500 symbols" do
    message = Factory.build(:message, :body => 'a' * 502 )
    message.should have_at_least(1).error_on(:body)
  end
end
