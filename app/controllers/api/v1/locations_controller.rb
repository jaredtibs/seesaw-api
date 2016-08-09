class Api::V1::LocationsController < Api::V1::BaseController
  before_action :authenticate_user!

  # check for posts at users current location
  # do not create new location if no location with unseen posts
  # is found
  def check
    @location = LocationService.find_nearest_location(params[:position])
    if @location.unseen_posts_for(current_user).any?
      # TODO send notification of posts if posts live at location
    end
    head :ok
  end

  # find or create the users nearest location
  # serialize location and its posts
  def show
    @location = LocationService.find_or_create_nearest_location(params[:position])
    render json: JSONAPI::Serializer.serialize(@location), status: :ok
  end

end
