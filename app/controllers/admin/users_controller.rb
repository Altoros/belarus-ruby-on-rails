class Admin::UsersController < ApplicationController
  load_and_authorize_resource :class => User

  def index
    respond_to do |format|
      format.html { @users = User.includes(:profile).filter(params[:filters])
        .paginate(:per_page => 10, :page => params[:page], :order => 'users.created_at DESC') }
      format.csv { export_csv(params[:filters]) }
    end
  end

  def update
    User.find(params[:id]).change_admin_state!
    redirect_to :action => :index
  end

  protected

  def export_csv(filters)
    filename = I18n.l(Time.now, :format => :short) + "- Users.csv"
    content = User.to_csv(User.includes(:profile).filter(filters))
    send_data content, :filename => filename
  end
end
