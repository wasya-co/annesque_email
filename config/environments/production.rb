require "active_support/core_ext/integer/time"

Rails.application.routes.default_url_options[:host] = "wasyaco.com"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load    = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = true # ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  config.log_level = :info
  config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  ## From: https://github.com/sidekiq/sidekiq/wiki/Active-Job#queues
  config.active_job.queue_adapter = :sidekiq
  config.active_job.queue_name_prefix = "wco_email_rb"
  config.active_job.queue_name_delimiter = "_"

  config.action_mailer.perform_caching = true
  config.action_mailer.deliver_later_queue_name = "mailers"

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  # Log disallowed deprecations.
  config.active_support.disallowed_deprecation = :log

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  # logger                  = ActiveSupport::Logger.new("log/#{ENV['APP_NAME']}-#{Rails.env}.log")
  # config.logger           = ActiveSupport::TaggedLogging.new(logger)

  config.logger           = ActiveSupport::Logger.new(STDOUT)

  config.log_formatter    = ::Logger::Formatter.new
  config.logger.formatter = config.log_formatter

end

Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    deliver_with: :deliver,
    email_prefix: '[Email] ',
    sender_address: %{micros_email <no-reply@wasya.co>},
    exception_recipients: %w{poxlovi@gmail.com}
  }

if ENV['APP_NAME']
  $stdout = File.new("log/#{ENV['APP_NAME']}-#{Rails.env}.log", 'w')
  $stdout.sync = true
end

DEBUG = false

