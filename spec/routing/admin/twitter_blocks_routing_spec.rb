require "spec_helper"

describe Admin::TwitterBlocksController do
  describe "admin routing" do

    it "routes to #edit" do
      get("/admin/twitter_blocks/1/edit").should route_to("admin/twitter_blocks#edit", :id => "1")
    end

    it "routes to #update" do
      put("/admin/twitter_blocks/1").should route_to("admin/twitter_blocks#update", :id => "1")
    end

  end
end
