require "active_support/core_ext/integer/time"

Rails.application.routes.default_url_options[:host] = "email.local:3004"
Rails.application.configure do
  config.hosts << "email.local"
  config.hosts << "localhost"

  config.cache_classes = false
  config.eager_load    = false
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false

  config.assets.debug = true
  config.assets.quiet = true

  config.mongoid.logger = Logger.new(nil, :error)

end

# Rails.application.config.middleware.use ExceptionNotification::Rack,
#   email: {
#     deliver_with: :deliver,
#     email_prefix: '[Email] ',
#     sender_address: %{micros_email <no-reply@wasya.co>},
#     exception_recipients: %w{poxlovi+zebradoc1@gmail.com}
#   }

DEBUG = true

