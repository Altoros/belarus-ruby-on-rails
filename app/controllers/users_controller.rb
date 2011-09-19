class UsersController < ApplicationController
  before_filter :authenticate_user!

  def reset_password
    if user_signed_in?
      current_user.send_reset_password_instructions
      flash[:notice] = I18n.t('devise.passwords.send_instructions')
    end

    redirect_to root_path
  end

end
