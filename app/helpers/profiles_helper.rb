module ProfilesHelper
  def provider_link(provider, displayed_user_id)
    link  = if provider.profile_link
              if provider.provider_name == :google_oauth2
                mail_to(provider.profile_link, '',  :class => "provider provider_#{provider.provider_name}")
              else
                link_to('', provider.profile_link, :target => '_blank', :class => "provider provider_#{provider.provider_name}")
              end
            elsif current_user.id == displayed_user_id
              link_to(I18n.t('omniauth.bind_with', :provider_name => provider.printable_name),
                      user_omniauth_authorize_path(provider.provider_name))
            end
    yield(link).html_safe if link
  end
end
