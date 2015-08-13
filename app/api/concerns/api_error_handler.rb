module APIErrorHandler
  extend ActiveSupport::Concern

  included do

    error_formatter :json, ->(message, backtrace, options, env) do
      Rails.logger.error("Responding error (data='#{message}').")
      message.to_json
    end
    
    rescue_from Unauthorized do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
            meta:{
              status: :failed ,
              code: 401,
              messages: :unauthorized
            },
            data: nil
          }, 
          status: 401 
        })
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      Rails.logger.error("Failed to validate (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { message: 
          { 
            meta:{
              status: :failed ,
              code: 404,
              messages: e.message
            },
            data: nil
          }, 
          status: 404 
        })
    end

    rescue_from ActionController::ParameterMissing do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
           meta:{
              status: :failed ,
              code: 400,
              messages: :parameter_missing
            },
            data: nil

          }, 
          status: 400 
        })
    end
    
    rescue_from Grape::Exceptions::ValidationErrors do |e|
      Rails.logger.error("Failed to process request (#{e.message}).")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
            meta:{
              status: :missing_params ,
              code: 405,
              messages: e.message
            },
            data: nil
          }, 
          status: 405
        })
    end

    rescue_from :all do |e|
      Rails.logger.error("Internal server error occurred.")
      Rails.logger.error("  type: #{e.class.name}")
      Rails.logger.error("  message: #{e.message}")
      Rails.logger.error("  backtrace:")
      Rails.logger.error("    " + e.backtrace.join("\n    "))
      error_response(
        { 
          message: 
          { 
            meta:{
              status: :failed ,
              code: 500,
              messages: :Internal_error
            },
            data: nil
          }, 
          status: 500 
        })
    end

  end
end
