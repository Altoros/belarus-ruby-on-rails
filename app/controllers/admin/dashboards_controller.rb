class Admin::DashboardsController < ApplicationController
  def show
    authorize! :manage, :all
  end
end