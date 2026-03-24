
DEFAULT_RECIPIENT = 'poxlovi@gmail.com'

Rails.application.configure do

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching       = false
  config.action_mailer.delivery_method       = :smtp
  config.action_mailer.default_url_options   = { :host => 'smt.creekenterprise.com' }
  config.action_mailer.smtp_settings = {
    :port                 => 587,
    :authentication       => :login,
    :enable_starttls_auto => true,
    :address              => 'smtp.gmail.com',
    :user_name            => 'no-reply@creekenterprise.com',
    :password             => 'hm',
  }

end

