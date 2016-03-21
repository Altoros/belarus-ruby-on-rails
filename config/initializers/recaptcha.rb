config_file_path = "#{Rails.root}/config/recaptcha_config.yml"

if File.exists?(config_file_path)
  # Load config for social services
  recaptcha_config = YAML.load_file(config_file_path)[Rails.env]

  Recaptcha.configure do |config|
    config.public_key  = recaptcha_config['public_key']
    config.private_key = recaptcha_config['private_key']
  end
end

module Recaptcha
  def self.configured?
    self.configuration.private_key.present?
  end
end

