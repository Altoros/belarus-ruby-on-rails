class Admin::AggregatorConfigurationsController < ApplicationController
  load_and_authorize_resource

  def edit
    @aggregator_configuration = AggregatorConfiguration.first || AggregatorConfiguration.new
  end

  def create
    respond_to do |format|
      if AggregatorConfiguration.create(params[:aggregator_configuration])
        format.html { redirect_to(admin_root_path, :notice => t('aggregator_configurations.successfully_updated')) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def update
    @aggregator_configuration = AggregatorConfiguration.first

    respond_to do |format|
      if @aggregator_configuration.update_attributes(params[:aggregator_configuration])
        format.html { redirect_to admin_root_path, :notice => t('aggregator_configurations.successfully_updated') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

end
