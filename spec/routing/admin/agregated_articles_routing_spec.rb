require "spec_helper"

describe AgregatedArticlesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/news").should route_to("admin/agregated_articles#index")
    end

    it "routes to #destroy" do
      delete("/admin/news/1").should route_to("admin/agregated_articles#destroy", :id => "1")
    end

  end
end
