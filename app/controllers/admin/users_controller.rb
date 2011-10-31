class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    store_location

    @users = User.paginate(:per_page => 10,
                    :page => params[:page],
                    :order => 'created_at DESC')
  end

  def update
    user = User.find(params[:id])
    case params[:attr]
      when 'admin'
        user.change_admin_state!
      when 'banned'
        user.change_banned_state!
    end

    redirect_to :action => :index
  end
end
