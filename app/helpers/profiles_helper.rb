module ProfilesHelper
  def provider_link(provider, displayed_user_id)
    if provider.profile_link
      link = !provider.profile_link.empty? ?
        link_to(provider.profile_link, provider.profile_link, :target => '_blank')
        : I18n.t('omniauth.no_profile_link')
    elsif current_user.id == displayed_user_id
      link = link_to(I18n.t('omniauth.bind_with', :provider_name => provider.printable_name),
                  user_omniauth_authorize_path(provider.provider_name))
    end

    yield(link).html_safe if link
  end
end
