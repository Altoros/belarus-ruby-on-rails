class Admin::AggregatorConfigurationsController < ApplicationController
  load_and_authorize_resource

  def edit
    @aggregator_configuration = AggregatorConfiguration.last || AggregatorConfiguration.new
  end

  def create
    @aggregator_configuration = AggregatorConfiguration.new(params[:aggregator_configuration])

    respond_to do |format|
      format.html {
        if @aggregator_configuration.save
          redirect_to(admin_root_path, :notice => t('aggregator_configurations.successfully_updated'))
        else
          render :action => "edit"
        end
      }
    end
  end

  def update
    @aggregator_configuration = AggregatorConfiguration.last

    respond_to do |format|
      format.html {
        if @aggregator_configuration.update_attributes(params[:aggregator_configuration])
          redirect_to(admin_root_path, :notice => t('aggregator_configurations.successfully_updated'))
        else
          render :action => "edit"
        end
      }
    end
  end

end
