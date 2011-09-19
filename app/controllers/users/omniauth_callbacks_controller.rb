class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include SessionsHelper

  def facebook
    select_provider(:facebook)
  end

  private

  def select_provider(provider)
    bind_provider_with_user if User.omniauth_providers.index(provider)
  end

  def get_omniauth_data
    @omniauth_data ||= env["omniauth.auth"]
  end

  def bind_provider_with_user
    omniauth = get_omniauth_data

    if current_user
      current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful"
      redirect_to get_stored_location
    else
      register_user
    end
  end

  def register_user
    omniauth = get_omniauth_data
    user_token = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if user_token
      user_sign_in_and_redirect user_token.user, get_stored_location
    else
      user = User.create_based_omniauth omniauth

      unless user.new_record?
        user_sign_in_and_redirect user, get_stored_location
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_based_omniauth_url
      end
    end
  end

  def user_sign_in_and_redirect(user, redirect_url = nil)
    omniauth = get_omniauth_data

    if omniauth
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
    end

    sign_in user
    if redirect_url
      redirect_to redirect_url
    else
      redirect_to user
    end
  end

end