Devise.setup do |config|

  credentials = SOCIAL_CONFIG['github'] || {}

  config.omniauth :github, credentials['app_id'], credentials['secret_key'],
                  :scope => 'user,public_repo'

  credentials = SOCIAL_CONFIG['facebook'] || {}
  config.omniauth :facebook, credentials['app_id'], credentials['secret_key'],
                  :scope => 'email'

  credentials = SOCIAL_CONFIG['vkontakte'] || {}
  config.omniauth :vkontakte, credentials['app_id'], credentials['secret_key']

  credentials = SOCIAL_CONFIG['twitter'] || {}
  config.omniauth :twitter, credentials['app_id'], credentials['secret_key']

  config.omniauth :google_apps, OpenID::Store::Filesystem.new('/tmp'),
                  :domain => 'gmail.com'

  credentials = SOCIAL_CONFIG['linkedin'] || {}
  config.omniauth :linked_in, credentials['app_id'], credentials['secret_key'],
                  :site => 'https://api.linkedin.com/',
                  :authorize_path => '/uas/oauth/authorize',
                  :access_token_path => '/uas/oauth/accessToken'
end
