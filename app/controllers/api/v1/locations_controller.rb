class Api::V1::LocationsController < Api::V1::BaseController
  #before_action :authenticate_user!
  before_action :set_coordinates, only: [:check, :show]
  before_action :find_location, only: [:create_post, :post]

  # takes factual id (from Engine) and checks for new posts for user
  # #TODO rename factual_id to external_id (?maybe)
  def ping
    @location = LocationService.find_current_location(params[:external_id])

    if LocationService.unseen_posts_for_user?(@location, current_user)
      # TODO send notification of posts if posts present at location
      # rpush https://github.com/rpush/rpush
    end

    head :ok
  end

  # receives factual data by client, received by Engine
  # finds or creates new location by Factual ID
  def engine_show
    @location = LocationService.engine_find_or_create_current_location(location_params)
    current_user.locations << @location
    render json: JSONAPI::Serializer.serialize(@location), status: :ok
  end

  # find or create the users nearest location
  # serialize location and its posts
  def show
    @location = LocationService.find_or_create_current_location(@coordinates)
    current_user.locations << @location
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

  def posts
=begin
    begin
      paginated_render json: @group.feed_activities( start_time: Time.at(@start_time),
                                                     offset: @offset,
                                                     limit: @limit,
                                                     type: params[:type]),
                       each_serializer: ActivityApiSerializer,
                       count: @group.activity_count.value,
                       pagination_token: response.headers,
                      status: :ok

    rescue => e
      notify_honeybadger e
      render json: {error: t('errors.something_went_wrong')}, status: :not_found
    end
=end

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
