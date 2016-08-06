class Api::V1::BaseController < ApplicationController

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

  def not_found
    render json: { errors: t('errors.not_found') }, status: :not_found
  end

  private

  def serialize(data, is_collection=false)
    JSONAPI::Serializer.serialize(data is_collection)
  end

end
