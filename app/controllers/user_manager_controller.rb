class UserManagerController < ApplicationController
  include UserManagerHelper
  before_filter :admin_filter

  def index
    @users = User.paginate(
        :per_page => 10,
        :page => params[:page],
        :order => 'created_at DESC'
                         )
  end

  def change_admin_state
    User.find(params[:id]).change_admin_state!
    redirect_to :controller => :user_manager
  end
end