require 'spec_helper'

describe Message do
  subject { Message.new }

  it { should respond_to(:subject) }
  it { should respond_to(:body) }
  it { should have_at_least(1).error_on(:subject) }
  it { should have_at_least(1).error_on(:body) }


  it "is not valid if subject is longer than 100 symbols" do
    message = Factory.build(:message, :subject => 'a' * 102 )
    message.should have_at_least(1).error_on(:subject)
  end

  it "is not valid if subject is longer than 500 symbols" do
    message = Factory.build(:message, :body => 'a' * 502 )
    message.should have_at_least(1).error_on(:body)
  end
end
