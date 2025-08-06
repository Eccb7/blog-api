module JsonapiErrors
  extend ActiveSupport::Concern

  included do
    def render_jsonapi_error(error, status:)
      render json: {
        errors: [ {
          status: status.to_s,
          title: error.class.name.demodulize,
          detail: error.message
        } ]
      }, status: status
    end
  end
end
