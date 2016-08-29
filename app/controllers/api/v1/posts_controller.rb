class Api::V1::PostsController < Api::V1::BaseController
  before_action :authenticate_user!
  before_action :find_post

  def upvote
    if current_user.upvote(@post)
      render json: {success: "upvoted"}, status: :ok
    else
      render json: {errors: "unable to upvote post"}, status: :unprocessable_entity
    end
  end

  def downvote
    if current_user.downvote(@post)
      render json: {success: "downvoted"}, status: :ok
    else
      render json: {errors: "unable to downvote post"}, status: :unprocessable_entity
    end
  end

  def unvote
    if current_user.unvote(@post)
      render json: {success: "vote removed"}, status: :ok
    else
      render json: {errors: "unable to delete vote"}, status: :unprocessable_entity
    end
  end

  def report
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
