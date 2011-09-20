class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:omniauth_new, :omniauth_create]

  def show
    @user = User.find(params[:id])
  end

  def reset_password_for_signed_user
    if user_signed_in?
      current_user.send_reset_password_instructions
      flash[:notice] = I18n.t('devise.passwords.send_instructions')
    end

    redirect_to root_path
  end

  def omniauth_new
    @user = User.new
  end

  # Create User based on user's data gotten from external service and e-mail entered by user
  def omniauth_create
    omniauth = session[:omniauth]
    @user = User.new params[:user]
    @user.apply_omniauth(omniauth)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, :notice => I18n.t("devise.confirmations.send_instructions") }
      else
        format.html { render :action => "omniauth_new" }
      end
    end
  end
end
