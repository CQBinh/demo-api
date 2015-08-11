class CoreAPI < Grape::API
  include APIExtensions
  prefix "api"
  version "v1", using: :path
  format :json
  formatter :json, Grape::Formatter::Rabl

  mount V1::BookAPI

end