class CoreAPI < Grape::API
  include APIExtensions

  prefix "api"
  version "v1", using: :path
  format :json
  formatter :json, Grape::Formatter::Rabl

  mount V1::BookAPI

  # Docs
  add_swagger_documentation  mount_path: "/api-docs",
                             api_version: "v1",
                             info: {
                                contact: "binh.cao@appconus.com",
                                description: %Q(Description area),
                                license: "Apache 2.0",
                                license_url: "http://www.apache.org/licenses/LICENSE-2.0.html",
                                terms_of_service_url: "http://helloreverb.com/terms/",
                                title: "Title App"
                             },
                             markdown: GrapeSwagger::Markdown::KramdownAdapter,
                             hide_documentation_path: true,
                             hide_format: true,
                             include_base_url: true

end