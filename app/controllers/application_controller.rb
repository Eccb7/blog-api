class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include JsonapiErrors

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity

  private

  def handle_not_found(exception)
    render_jsonapi_error(exception, status: :not_found)
  end

  def handle_unprocessable_entity(exception)
    render_jsonapi_error(exception, status: :unprocessable_entity)
  end
end
