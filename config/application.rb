# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Refine
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end
    # fluentd config
    config.log_level = :info
    config.logger = ActFluentLoggerRails::Logger.new(
      settings: {
        host: '127.0.0.1',
        port: 24_224,
        tag: 'foo',
        messages_type: 'string',
        severity_key: 'level'
      }
    )
    config.lograge.enabled = true
    config.lograge.formatter = Lograge::Formatters::Json.new
  end
end
