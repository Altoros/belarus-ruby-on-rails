require 'spec_helper'

describe UsersFilter do
  before(:each) do
    @user_subscribed = Factory(:user, :profile => Factory(:profile,
                                                  :subscribed => true,
                                                  :experience => Factory(:experience)))
    @user_unsubscribed = Factory(:user)
    @admin = Factory(:user, :is_admin => true)
  end

  describe "#filters_collection" do
    it "should be Hash" do
      UsersFilter.filters_collection.should be_a(Hash)
    end

    it "contains 'all' option" do
      UsersFilter.filters_collection.should be_value('all')
    end
  end

  describe "#emails_list" do
    let(:email_list) { UsersFilter.emails_list(0) }

    it "contains email of subscribed user" do
      email_list.should include(@user_subscribed.email)
    end

    it "does not contain email of unsubscribed user" do
      email_list.should_not include(@user_unsubscribed.email)
    end

    it "does not contain email of admin" do
      email_list.should_not include(@admin.email)
    end
  end
end
