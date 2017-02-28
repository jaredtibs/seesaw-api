class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user!
  before_action :find_post

  def upvote
    if current_user.upvote(@post)
      render json: JSONAPI::Serializer.serialize(@post, context: current_user), status: :ok
    else
      render json: {errors: "unable to upvote post"}, status: :unprocessable_entity
    end
  end

  def downvote
    if current_user.downvote(@post)
      render json: JSONAPI::Serializer.serialize(@post, context: current_user), status: :ok
    else
      render json: {errors: "unable to downvote post"}, status: :unprocessable_entity
    end
  end

  def unvote
    if current_user.unvote(@post)
      render json: JSONAPI::Serializer.serialize(@post, context: current_user), status: :ok
    else
      render json: {errors: "unable to delete vote"}, status: :unprocessable_entity
    end
  end

  def report
    if current_user.report(@post)
      render json: {success: "post reported"}, status: :ok
    else
      render json: {errors: "unable to report post"}, status: :unprocessable_entity
    end
  end

  def upvotes
  end

  def downvotes
  end

  private

  def find_post
    @post = Post.find params[:id]
  rescue
    render json: {error: "post not found"}, status: :not_found
  end
end
