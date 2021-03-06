module APIExtensions
  extend ActiveSupport::Concern

  included do
    include APIErrorHandler
    include APIRequestParameterConverter
    include Authorizable
  end
  
end
