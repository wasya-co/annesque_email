
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

require 'wco_models'

module MicrosEmail
  class Application < Rails::Application
    config.load_defaults 6.1

    config.generators.system_tests = nil
    config.encoding = "utf-8"

    config.generators do |g|
      g.orm :mongoid
    end

    config.time_zone = 'Central Time (US & Canada)'
  end
end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :delete, :get, :patch, :post, :put]
  end
end

def json_puts! a, b=''
  puts "+++ #{b}:"
  print JSON.pretty_generate( a )
  STDOUT.flush
end

def puts! a, b=''
  puts "+++ +++ #{b}:"
  puts a.inspect
end

def print! a, b=''
  puts "+++ #{b}:"
  print a
  STDOUT.flush
end
