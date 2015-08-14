module Authorizable 
  extend ActiveSupport::Concern
  included do
    helpers do
      def authenticate!
      	has_api_key = headers['Access-Token'].eql? "foo"
        fail Unauthorized unless has_api_key
      end
    end
  end
end