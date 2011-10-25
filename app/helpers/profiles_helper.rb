module ProfilesHelper
  def provider_link(provider, displayed_user_id)
    link  = if provider.profile_link
              if provider.provider_name == :google_apps
                provider.profile_link
              else
                link_to( image_tag(provider.provider_icon, :alt => provider.class.name.split('::').last ),
                        provider.profile_link, :target => '_blank' )
              end
            elsif current_user.id == displayed_user_id
              link_to(I18n.t('omniauth.bind_with', :provider_name => provider.printable_name),
                      user_omniauth_authorize_path(provider.provider_name))
            end
    yield(link).html_safe if link
  end
end
