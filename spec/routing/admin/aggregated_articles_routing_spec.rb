require "spec_helper"

describe AggregatedArticlesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/news").should route_to("admin/aggregated_articles#index")
    end

    it "routes to #destroy" do
      delete("/admin/news/1").should route_to("admin/aggregated_articles#destroy", :id => "1")
    end

  end
end
