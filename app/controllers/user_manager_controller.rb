class UserManagerController < ApplicationController
  before_filter :admin_filter

  def index
    @users = User.paginate per_page: 10,
                          page: params[:page],
                          order: 'created_at DESC'
  end

  def change_admin_state
    (@user = User.find(params[:id])).change_admin_state
    redirect_to controller: :user_manager
  end

  private
  def admin_filter
    filter :admin
  end
end
