
DEFAULT_RECIPIENT = '$recipient'

Rails.application.configure do

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching       = false
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.default_url_options   = { :host => '$host' }
  config.action_mailer.smtp_settings = {
    :port                 => 587,
    :authentication       => :login,
    :enable_starttls_auto => true,
    :address              => 'smtp.gmail.com',
    :user_name            => '$username',
    :password             => 'hm',
  }

end

