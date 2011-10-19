# Load the rails application
require File.expand_path('../application', __FILE__)

# Load config for social services
SOCIAL_CONFIG = YAML.load_file("#{Rails.root}/config/social_config.yml")[Rails.env]

# Initialize the rails application
BelarusRubyOnRails::Application.initialize!
