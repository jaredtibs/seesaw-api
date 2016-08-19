class Api::V1::LocationsController < Api::V1::BaseController
  #before_action :authenticate_user!
  before_action :set_coordinates, only: [:check, :show]
  before_action :find_location, only: [:create_post]

  # check for posts at users current location
  # do not create new location if no location with unseen posts
  # is found
  # ?position=34.036217,-118.47346
  def check
    @location = LocationService.find_current_location(@coordinates)

    if @location.unseen_posts_for(current_user).any?
      # TODO send notification of posts if posts present at location
      # rpush https://github.com/rpush/rpush
    end

    head :ok
  end

  # find or create the users nearest location
  # serialize location and its posts
  def show
    @location = LocationService.find_or_create_current_location(@coordinates)
    current_user.locations << @location
   # UpdateVisitorTimestamp.perform_async(current_user.id, @location.id)
    render json: JSONAPI::Serializer.serialize(@location), status: :ok
  end

  def create_post
    @post = @location.posts.build(post_params)

    if @post.save
      current_user.posts << @post
      render json: JSONAPI::Serializer.serialize(@post), status: :created
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def set_coordinates
    @coordinates = params[:position].split(",")
  end

  def find_location
    @location = Location.find(params[:location_id])
  rescue
    render json: {error: "Location not found"}, status: :not_found
  end

  def post_params
    params.permit(
      :body
    )
  end


end
