$ rails new demo-api -d postgresql

#Gemfile
# Use Unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# API gems
gem 'grape'
gem 'grape-rabl'
gem 'yajl-ruby', require: 'yajl'
# Ducomments grape
gem 'grape-swagger'
gem 'grape-swagger-rails'

$bundle install

$ cd config/initializers/
$ touch rabl.rb
class PrettyJson
  def self.dump(object)
    JSON.pretty_generate(object, indent: "    ")
  end
end

Rabl.configure do |config|
  config.json_engine = PrettyJson if Rails.env.development?
  config.include_json_root = false
end

$ cd app
$ mkdir api
$ cd api/
$ mkdir v1
$ mkdir concerns
$ cd concerns/

$ touch api_error_handler.rb
$ touch api_request_parameter_converter.rb
$ touch api_extensions.rb

config/application.rb

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

$ rails g model Book title description 'price:decimal{10,2}'
$ rake db:create
$ rake db:migrate
update Book module

make api/ folder in app/views/
make layouts/ folder in app/views/api/
$ touch application.rabl
$ touch error.rabl
$ cd ..
$ mkdir books
$ touch _book.rabl
$ touch show.rabl


mount CoreAPI => '/'