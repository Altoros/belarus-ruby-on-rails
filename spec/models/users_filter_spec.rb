require 'spec_helper'

describe UsersFilter do
  before(:all) do
    @meetup = Factory :meetup
    @filters = UsersFilter.collection(true)
  end

  describe "#filters_collection" do
    it "should be Hash" do
      @filters.should be_a(Hash)
    end

    it "contains 'all' option" do
      @filters.should be_value('all')
    end

    it "contains active meetup option" do
      @filters.should be_value(@meetup.topic)
    end
  end

  describe "#emails_list" do
    before(:all) do
      @user_subscribed = Factory(:user, :profile => Factory(:profile,
                                                    :subscribed => true,
                                                    :experience => Factory(:experience)))
      @user_unsubscribed = Factory(:user)
      @admin = Factory(:user, :is_admin => true, :profile => Factory(:profile,
                                                    :subscribed => true,
                                                    :experience => Factory(:experience)))

      @user_subscribed.participants.create(:meetup_id => @meetup.id)
      @user_unsubscribed.participants.create(:meetup_id => @meetup.id)

      @email_list = UsersFilter.emails_list(['0', @meetup.id.to_s])
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

    it "does not contain duplicate" do
      @email_list.uniq!.should be_nil
    end
  end
end
