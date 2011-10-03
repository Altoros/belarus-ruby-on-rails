require 'spec_helper'

describe StaticPageController do

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'friends'" do
    it "should be successful" do
      get 'friends'
      response.should be_success
    end
  end

end
