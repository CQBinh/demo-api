require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module DemoApi
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("app", "api", "concerns")

    config.middleware.use(Rack::Config) do |env|
      env["api.tilt.root"] = Rails.root.join("app", "views", "api")
    end
    config.active_record.raise_in_transactional_callbacks = true
  end
end
