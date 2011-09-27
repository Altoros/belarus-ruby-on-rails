class UserManagerController < ApplicationController
  def index
    authorize! :manage, User

    @users = User.paginate(
        :per_page => 10,
        :page => params[:page],
        :order => 'created_at DESC'
                         )
  end

  def change_admin_state
    authorize! :manage, User

    User.find(params[:id]).change_admin_state!
    redirect_to :action => :index
  end
end