require "spec_helper"

describe Admin::AggregatorConfigurationsController do
  describe "routing" do

    it "routes to #edit" do
      get("/admin/aggregator_configurations/1/edit").should route_to("admin/aggregator_configurations#edit", :id => "1")
    end

    it "routes to #update" do
      put("/admin/aggregator_configurations/1").should route_to("admin/aggregator_configurations#update", :id => "1")
    end

  end
end
