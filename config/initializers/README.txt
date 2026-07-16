

Rails.application.config.middleware.use ExceptionNotification::Rack,
  email: {
    deliver_with: :deliver,
    email_prefix: '[Email] ',
    sender_address: %{micros_email <no-reply@wasya.co>},
    exception_recipients: %w{poxlovi@gmail.com}
  }

