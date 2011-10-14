# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BelarusRubyOnRails::Application.initialize!

require 'tlsmail'
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :tls                  => true,
  :domain               => 'gmail.com',
  :user_name            => 'belarusrubyonrails@gmail.com',
  :password             => 'bror-altoros',
  :authentication       => 'plain',
  :enable_starttls_auto => true,
}

