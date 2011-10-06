class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include SessionsHelper

  def facebook
    bind_provider_with_user if User.omniauth_providers.index(:facebook)
  end

  def vkontakte
    bind_provider_with_user if User.omniauth_providers.index(:vkontakte)
  end

  def google_apps
    env['omniauth.auth']['uid'] = env['omniauth.auth']['user_info']['email']
    bind_provider_with_user if User.omniauth_providers.index(:google_apps)
  end

  private

  def get_omniauth_data
    @omniauth_data ||= env["omniauth.auth"]
  end

  def bind_provider_with_user
    omniauth = get_omniauth_data

    if current_user
      current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      provider_name = Provider::Factory.get_instance(omniauth['provider']).printable_name
      flash[:notice] = I18n.t('omniauth.successfully_binded', :provider_name => provider_name)
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
        redirect_to omniauth_signup_url
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
      redirect_to user.profile
    end
  end

end
