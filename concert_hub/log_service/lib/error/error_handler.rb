# Error module to Handle errors globally
# include Error::ErrorHandler in application_controller.rb
module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError, RuntimeError do |e|
          respond(:internal_server_error, e.to_s)
        end
        rescue_from EntryNotFound, with: :entry_not_found_response
        rescue_from EntryInvalid, with: :entry_invalid_response
        rescue_from NotAuthorized, with: :not_authorized_response
        rescue_from NotAuthenticate, with: :not_authenticate_response
      end
    end

    private

    def entry_not_found_response(error)
      json = Helpers::Render.json(error.message)
      render json: json, status: :not_found # 404
    end

    def entry_invalid_response(error)
      json = Helpers::Render.json(error.message, error.details)
      render json: json, status: :not_acceptable # 406
    end

    def not_authorized_response(error)
      json = Helpers::Render.json(error.message)
      render json: json, status: :unauthorized # 401
    end

    def not_authenticate_response(error)
      redirect_to :login, notice: error.message
    end

    def respond(status, message)
      json = Helpers::Render.json(message)
      render json: json, status: status
    end
  end
end
