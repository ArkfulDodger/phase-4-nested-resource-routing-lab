class ApplicationController < ActionController::API
  # error handling for non-existent records and failed validations
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  private

  # response when requested record not in database
  def render_not_found_response
    render json: { error: 'Not found' }, status: :not_found
  end
end
