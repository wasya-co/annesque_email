
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.use_active_record = false
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Devise::TestHelpers, :type => :controller
  # config.include FactoryBot::Syntax::Methods

  config.include Capybara::DSL

end

Capybara.configure do |config|
  config.default_max_wait_time = 5

  config.app_host = "https://zerohedge.com"
  config.run_server = false

  config.default_driver = :remote_browser
  config.javascript_driver = :remote_browser
end

