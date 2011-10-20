class Admin::DashboardsController < ApplicationController
  def show
    authorize! :manage, :all
    @aggregator_configurations = AggregatorConfiguration.first
  end
end
