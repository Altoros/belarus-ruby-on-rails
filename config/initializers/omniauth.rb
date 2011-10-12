CONFIG = YAML.load_file("#{Rails.root}/config/credentials.yml")[Rails.env]

Devise.setup do |config|

  credentials = CONFIG['github']
  config.omniauth :github, credentials['app_id'], credentials['secret_key'], :scope => 'user,public_repo'

  credentials = CONFIG['facebook']
  config.omniauth :facebook, credentials['app_id'], credentials['secret_key'], {:scope => 'email'}

  credentials = CONFIG['vkontakte']
  config.omniauth :vkontakte, credentials['app_id'], credentials['secret_key']

  credentials = CONFIG['twitter']
  config.omniauth :twitter, credentials['app_id'], credentials['secret_key']

  config.omniauth :google_apps, OpenID::Store::Filesystem.new('/tmp'), :domain => 'gmail.com'
end
