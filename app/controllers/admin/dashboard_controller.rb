class Admin::DashboardController < ApplicationController
  def show
    authorize! :manage, :all
  end
end