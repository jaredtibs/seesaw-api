class Api::V1::LocationsController < Api::V1::BaseController
  before_action :authenticate_user!

  #def nearby
  #  @locations = LocationService...(params[:position])
  #  render json: JSONAPI::Serializer.serialize(
  #    @locations,
  #    meta: { count: @locations.count },
  #    is_collection: true),
  #    status: :ok
  #end

  def ping
    @location = LocationService.find_or_create_nearest_location(params[:position])
    if @location.unseen_posts_for(current_user).any?
      # TODO send notification of posts if posts live at location
    end

    render json: JSONAPI::Serializer.serialize(@location), status: :ok
  end

end
