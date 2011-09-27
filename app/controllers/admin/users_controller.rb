class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    @users = User.paginate(:per_page => 10,
                    :page => params[:page],
                    :order => 'created_at DESC')
  end

  def update
    User.find(params[:id]).change_admin_state!
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = I18n.t "admin.users.not_found"
  ensure
    redirect_to :action => :index
  end
end