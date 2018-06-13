class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:reset_password]

  def reset_password
    user = User.find(params[:id])
    if user_signed_in? && can?(:reset_password, User) && user
      user.send_reset_password_instructions
      flash[:notice] = t('admin.users.reset_password_notice')
    end

    redirect_to get_stored_location
  end

  def new
    omniauth_data = session["devise.omniauth"]
    @user = User.build_via_social_network(omniauth_data)
  end

  # Create User based on user's data gotten from external service and e-mail entered by user
  def create
    omniauth_data = session["devise.omniauth"]

    @user = User.build_via_social_network(omniauth_data, user_params)

    respond_to do |format|
      if @user.valid?
        if omniauth_data.info.email
          @user.confirm!
          sign_in @user
          provider_name = Provider::Factory.get_instance(omniauth_data.provider).printable_name
          notice = t('devise.omniauth_callbacks.success', :kind => provider_name)
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

  def unsubscribe
    user = User.find_by_email(params[:email])
    if user && params[:token] == user.unsubscribe_token
      user.profile.update_attributes({:subscribed => false, :subscribed_for_comments => false})
      notice = t("users.successfully_unsubscribed")
      Notifier.user_unsubscribed(user).deliver
    else
      notice = t("users.failed_to_unsubscribe")
    end

    redirect_to(root_path, :notice => notice) and return
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      profile_attributes: %i(first_name last_name experience_id subscribed subscribed_for_comments locale)
    )
  end
end
