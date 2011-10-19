require "spec_helper"

describe Admin::TwitterBlocksController do
  describe "admin routing" do

    it "routes to #index" do
      get("/admin/twitter_blocks").should route_to("admin/twitter_blocks#index")
    end

    it "routes to #new" do
      get("/admin/twitter_blocks/new").should route_to("admin/twitter_blocks#new")
    end

    it "routes to #edit" do
      get("/admin/twitter_blocks/1/edit").should route_to("admin/twitter_blocks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/twitter_blocks").should route_to("admin/twitter_blocks#create")
    end

    it "routes to #update" do
      put("/admin/twitter_blocks/1").should route_to("admin/twitter_blocks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/twitter_blocks/1").should route_to("admin/twitter_blocks#destroy", :id => "1")
    end
  end
end
