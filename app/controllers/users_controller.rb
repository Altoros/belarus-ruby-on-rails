class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def reset_password_for_signed_user
    if user_signed_in?
      some = current_user.send_reset_password_instructions
      flash[:notice] = I18n.t('devise.passwords.send_instructions')
    end

    redirect_to root_path
  end

end
