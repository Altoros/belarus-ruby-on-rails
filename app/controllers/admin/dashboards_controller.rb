class Admin::DashboardsController < ApplicationController
  def show
    authorize! :manage, :all
    @twitter_block = TwitterBlock.first
  end
end
