require 'spec_helper'

describe Admin::AggregatorConfigurationsController do
  before(:each) do
    sign_in Factory(:user, :is_admin => true)
  end

  describe "#edit" do
    it "assigns the requested aggregator_configuration as @aggregator_configuration" do
      assigns(:aggregator_configuration).should eq(@aggregator_configuration)
    end
  end

  describe "#update" do
    it "assigns the requested aggregator_configuration as @aggregator_configuration" do
      assigns(:aggregator_configuration).should eq(@aggregator_configuration)
    end
  end

end
