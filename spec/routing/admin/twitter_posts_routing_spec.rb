require "spec_helper"

describe Admin::TwitterPostsController do
  describe "admin routing" do

    it "routes to #edit" do
      get("/admin/twitter_posts/1/edit").should route_to("admin/twitter_posts#edit", :id => "1")
    end

    it "routes to #update" do
      put("/admin/twitter_posts/1").should route_to("admin/twitter_posts#update", :id => "1")
    end

  end
end
