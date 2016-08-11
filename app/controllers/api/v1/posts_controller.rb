class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: JSONAPI::Serializer.serialize(@post), status: :created
    else
      render json: {errors: @post.errors.full_messages}, status: :unprocessable_entity
    end
  end


  private

  def post_params
    params.permit(
      :location_id,
      :body
    )
  end

end
