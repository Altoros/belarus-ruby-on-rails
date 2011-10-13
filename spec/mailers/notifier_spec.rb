require "spec_helper"

describe Notifier do
  describe '.custom' do
    let(:user) { Factory.stub(:user) }
    let(:message) { Message.new(Factory.attributes_for(:message)) }
    let(:mail) { Notifier.custom(user.email, message.subject, message.body) }

    it 'renders the subject' do
      mail.subject.should eq(message.subject)
    end

    it 'renders the body' do
      mail.body.should eq(message.body)
    end

    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
  end

  describe '.comment' do
    let(:user) { Factory.stub(:user) }
    let(:article) { Factory.stub(:article) }
    let(:mail) { Notifier.comment(user.email, article) }

    it 'renders the article title' do
      mail.body.should include(article.title)
    end

    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
  end
end
