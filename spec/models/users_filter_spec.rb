require 'spec_helper'

describe UsersFilter do
  describe "#filters_collection" do
    it "should be Hash" do
      UsersFilter.collection.should be_a(Hash)
    end

    it "contains 'all' option" do
      UsersFilter.collection.should be_value('all')
    end
  end

  describe "#emails_list" do
    before(:each) do
      @user_subscribed = Factory(:user, :profile => Factory(:profile,
                                                    :subscribed => true,
                                                    :experience => Factory(:experience)))
      @user_unsubscribed = Factory(:user)
      @admin = Factory(:user, :is_admin => true)
      @email_list = UsersFilter.emails_list('0')
    end

    it "contains email of subscribed user" do
      @email_list.should include(@user_subscribed.email)
    end

    it "does not contain email of unsubscribed user" do
      @email_list.should_not include(@user_unsubscribed.email)
    end

    it "does not contain email of admin" do
      @email_list.should_not include(@admin.email)
    end
  end
end
