require "spec_helper"

describe CustomNewsController do
  describe "routing" do

    it "routes to #index" do
      get("/custom_news").should route_to("custom_news#index")
    end

    it "routes to #new" do
      get("/custom_news/new").should route_to("custom_news#new")
    end

    it "routes to #show" do
      get("/custom_news/1").should route_to("custom_news#show", :id => "1")
    end

    it "routes to #edit" do
      get("/custom_news/1/edit").should route_to("custom_news#edit", :id => "1")
    end

    it "routes to #create" do
      post("/custom_news").should route_to("custom_news#create")
    end

    it "routes to #update" do
      put("/custom_news/1").should route_to("custom_news#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/custom_news/1").should route_to("custom_news#destroy", :id => "1")
    end

  end
end
