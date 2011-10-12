class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include SessionsHelper

  before_filter :get_omniauth_data, :only => [:facebook,
                                              :vkontakte,
                                              :google_apps,
                                              :twitter,
                                              :github]

  def facebook
    bind_provider_with_user(:facebook)
  end

  def vkontakte
    bind_provider_with_user(:vkontakte)
  end

  def google_apps
    env['omniauth.auth']['uid'] = env['omniauth.auth']['user_info']['email']
    bind_provider_with_user(:google_apps)
  end

  def twitter
    env["omniauth.auth"]["uid"] = env["omniauth.auth"]["user_info"]["nickname"]
    bind_provider_with_user(:twitter)
  end

  def github
    env['omniauth.auth']['uid'] = env['omniauth.auth']['user_info']['nickname']
    bind_provider_with_user(:github)
  end

  private

  def get_omniauth_data
    @omniauth_data ||= env["omniauth.auth"]
  end

  def bind_provider_with_user(provider)
    return unless User.omniauth_providers.index(provider)

    provider = @omniauth_data['provider']
    uid = @omniauth_data['uid']
    email = @omniauth_data['user_info']['email']

    if current_user
      current_user.bind_social_network(provider, uid)

      provider_name = Provider::Factory.get_instance(provider).printable_name
      flash[:notice] = t('omniauth.successfully_binded', :provider_name => provider_name)

      redirect_to get_stored_location
    else
      user = User.find_by_email(email) if email
      user ||= User.find_by_social_network(provider, uid)

      user ? user_sign_in_and_redirect(user, get_stored_location) : register_user
    end
  end

  def register_user
    session["devise.omniauth"] = @omniauth_data.except('extra')
    redirect_to new_user_url
  end

  def user_sign_in_and_redirect(user, redirect_url = nil)
    if @omniauth_data
      flash[:notice] = t("devise.omniauth_callbacks.success", :kind => @omniauth_data['provider'])
    end

    sign_in user
    if redirect_url
      redirect_to redirect_url
    else
      redirect_to user.profile
    end
  end

end
