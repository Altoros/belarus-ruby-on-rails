class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def method_missing(provider)
    if !User.omniauth_providers.index(provider).nil?
      bind_provider_with_user
    end
  end

  private

  def get_omniauth_data
    env["omniauth.auth"]
  end


  def bind_provider_with_user
    omniauth = get_omniauth_data

    if current_user
      current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful"
      redirect_to edit_user_registration_path
    else
      register_user
    end
  end

  def register_user
    omniauth = get_omniauth_data

    user_token = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if user_token
      user_sign_in_and_redirect user_token.user
    else

      user = User.create_based_omniauth omniauth

      if user.save
        user_sign_in_and_redirect user
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
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