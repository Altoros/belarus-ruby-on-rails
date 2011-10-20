class Admin::AggregatorConfigurationsController < ApplicationController
  load_and_authorize_resource

  def edit
    @aggregator_configuration = AggregatorConfiguration.first
  end

  def update
    @aggregator_configuration = AggregatorConfiguration.first

    respond_to do |format|
      if @aggregator_configuration.update_attributes(params[:aggregator_configuration])
        format.html { redirect_to edit_admin_aggregator_configuration_path(@aggregator_configuration),
                      :notice => t('aggregator_configurations.successfully_updated') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @aggregator_configuration.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

end
