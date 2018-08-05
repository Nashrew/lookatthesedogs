require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LookAtTheseDogs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Don't generate system test files.
    config.generators.system_tests = nil
    
    
    # Disable serving static files from the `/public` folder by default since
    # Apache or NGINX already handles this.
    # config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
    
    # if ENV["RAILS_LOG_TO_STDOUT"].present?
    #   logger           = ActiveSupport::Logger.new(STDOUT)
    #   logger.formatter = config.log_formatter
    #   config.logger = ActiveSupport::TaggedLogging.new(logger)
    # end
  end
end
