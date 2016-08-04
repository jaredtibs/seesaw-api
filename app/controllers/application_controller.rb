class ApplicationController < ActionController::API
  def bad_request
    render json: { errors: t('errors.unauthorized') }, status: :bad_request
  end

  def unauthorized
    render json: { errors: t('errors.unauthorized') }, status: :unauthorized
    return false
  end

  def server_error
    render json: { errors: t('errors.server_error') }, status: :internal_server_error
  end

end
