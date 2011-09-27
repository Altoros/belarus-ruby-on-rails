class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    @users = User.paginate(:per_page => 10,
                    :page => params[:page],
                    :order => 'created_at DESC')
  end

  def update
    User.find(params[:id]).change_admin_state!
    redirect_to :action => :index
  end
end