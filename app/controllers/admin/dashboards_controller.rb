class Admin::DashboardsController < ApplicationController
  def show
    authorize! :manage, :all
    @twitter_post = TwitterPost.first
  end
end