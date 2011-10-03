class Admin::DashboardController < ApplicationController
  def index
    authorize! :manage, :all
  end
end