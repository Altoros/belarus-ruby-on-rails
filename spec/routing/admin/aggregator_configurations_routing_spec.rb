require "spec_helper"

describe Admin::AggregatorConfigurationsController do
  describe "routing" do

    it "routes to #edit" do
      get("/admin/aggregator_configurations/edit").should route_to("admin/aggregator_configurations#edit")
    end

    it "routes to #update" do
      put("/admin/aggregator_configurations").should route_to("admin/aggregator_configurations#update")
    end

  end
end
