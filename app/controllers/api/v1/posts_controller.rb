class Api::V1::PostsController < Api::V1::BaseController
  #before_action :authenticate_user!
  before_action :find_post

  #TODO remove hardcoded votes for authenticated user votes
  # and uncomment authenticate call above
  def upvote
    #if current_user.upvote(@post)
    if @post.increment!(:upvote_count)
      render json: {success: "upvoted"}, status: :ok
    else
      render json: {errors: "unable to upvote post"}, status: :unprocessable_entity
    end
  end

  def downvote
    #if current_user.downvote(@post)
    if @post.decrement!(:upvote_count)
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
