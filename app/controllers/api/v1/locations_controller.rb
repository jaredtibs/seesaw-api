class Api::V1::LocationsController < Api::V1::BaseController
  before_action :authenticate_user!
  before_action :find_location, only: [:create_post, :posts]

  # takes place id (from Engine) and checks for new posts for user
  # will need to ping this every time the iOS background location tracking
  # recognizes a change
  def ping
    @location = LocationService.find_current_location(params[:external_id])

    if LocationService.unseen_posts_for_user?(@location, current_user)
      # TODO send notification of posts if posts present at location
      # rpush https://github.com/rpush/rpush
    end

    head :ok
  end

  def show
    if location_params[:place_id]
      @location = LocationService.find_or_create_factual_location(location_params.to_hash)
    else
      lat, long = location_params[:latitude], location_params[:longitude]
      @location = LocationService.find_or_create_raw_location(lat, long)
    end

    if @location
      LocationService.visit_for_user(current_user, @location)
      render json: @location, serializer: LocationSerializer, status: :ok
    else
      render json: { error: "Location not found." }, status: :not_found
    end
  end

  def posts
    @posts = @location.posts.order(sort_column + ' ' + 'desc, created_at desc')
    render json: @posts,
      meta: {count: @posts.count},
      each_serializer: PostSerializer,
      scope: current_user,
      scope_name: :current_user,
      status: :ok
  end

  def create_post
    @post = @location.posts.build(post_params)

    @post.image_data = post_params[:media] if post_params[:media].present?

    if @post.save
      current_user.posts << @post
      Location.increment_counter(:cached_post_count, @location.id)
      render json: @post, serializer: PostSerializer, status: :created
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end

=begin
  def posts
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

  end
=end

  private

  def find_location
    @location = Location.find(params[:id])
  rescue
    render json: {error: "Location not found"}, status: :not_found
    return
  end

  def sort_column
    case params[:sort]
    when 'recent' then 'created_at'
    when 'popular' then 'upvote_count'
    else 'created_at'
    end
  end

  def location_params
    params.permit(
      :latitude,
      :longitude,
      :location,
      :place_id,
      :name,
      :category_ids => []
    )
  end

  def post_params
    params.permit(
      :body,
      :media,
      :visibility,
      :direct_participants => []
    )
  end


end
