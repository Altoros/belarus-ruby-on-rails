class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:reset_password]

  def reset_password
    if user_signed_in?
      current_user.send_reset_password_instructions
      flash[:notice] = t('devise.passwords.send_instructions')
    end

    redirect_to root_path
  end

  def new
    omniauth_data = session["devise.omniauth"]
    @user = User.build_via_social_network(omniauth_data)
  end

  # Create User based on user's data gotten from external service and e-mail entered by user
  def create
    omniauth_data = session["devise.omniauth"]

    profile_attributes = params[:user][:profile_attributes]

    @user = User.build_via_social_network(omniauth_data)
    @user.email = params[:user][:email] if params[:user][:email]
    @user.profile.subscribed = profile_attributes[:subscribed]
    @user.profile.experience_id = profile_attributes[:experience_id]

    respond_to do |format|
      if @user.valid?
        if omniauth_data["user_info"]["email"]
          @user.confirm!
          sign_in @user
          notice = t('devise.omniauth_callbacks.success', :kind => omniauth_data['provider'])
        else
          @user.save
          notice = t("devise.confirmations.send_instructions")
        end

        format.html { redirect_to root_path, :notice => notice }
      else
        format.html { render :action => :new }
      end
    end
  end
end
