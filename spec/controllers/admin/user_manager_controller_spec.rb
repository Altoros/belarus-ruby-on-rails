require 'spec_helper'

describe Admin::UsersController do

  describe "For anonymous user" do
    it "should not show user list" do
      get 'index'
      response.should_not be_success
    end

    it "should not change admin rights" do
      put 'update'
      response.should_not be_success
    end
  end

  describe "For admins" do
    let(:admin) { Factory(:user, :is_admin => true) }
    before(:each) do
      sign_in admin
    end

    it "should show user list" do
      get 'index'
      response.should be_success
    end

    it "should change admins" do
      user = Factory(:user)
      put 'update', { :id => user.id, :attr => 'admin' }
      User.find(user.id).is_admin?.should be_true
    end

    it "should change ban state" do
      user = Factory(:user)
      put 'update', { :id => user.id, :attr => 'banned' }
      User.find(user.id).banned?.should be_true
    end

    context 'downloaded CSV file' do
      before(:each) do
        require 'iconv'
        @meetup = Factory(:meetup)
        @exp = Factory(:experience)
        @first_user = Factory(:user, :profile => Factory(:profile, :subscribed => true, :experience => @exp))
        @second_user = Factory(:user, :profile => Factory(:profile,:subscribed => true, :experience => @exp))

        Participant.create(:meetup_id => @meetup.id, :user_id => @first_user.id)
      end

      it 'should contain all users for "All" filter' do
        post 'index', { :format => 'csv' }
        response.header['Content-Disposition'].should include('attachment')
        response.header['Content-Disposition'].should include('csv')
        csv = Iconv.conv('UTF-8', 'UTF-16', response.body)
        csv.should include(@first_user.email)
        csv.should include(@second_user.email)
      end

      it 'should contain only participants of meetup for selected filter' do
        post 'index', { :format => 'csv', :filters => ["#{ @meetup.id}"] }
        response.header['Content-Disposition'].should include('attachment')
        response.header['Content-Disposition'].should include('csv')
        csv = Iconv.conv('UTF-8', 'UTF-16', response.body)
        csv.should include(@first_user.email)
        csv.should_not include(@second_user.email)
      end
    end
  end
end
