module ProfilesHelper
  def provider_link(provider, displayed_user_id)
    if provider.profile_link
      link = link_to provider.profile_link
    else
      link = link_to("Bind with #{provider.printable_name}",
                  user_omniauth_authorize_path(provider.provider_name)) if current_user.id == displayed_user_id
    end

    yield(link).html_safe if link
  end
end