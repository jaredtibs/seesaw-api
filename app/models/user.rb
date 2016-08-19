class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :recoverable

  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :posts

  acts_as_voter

  def upvote(post)
    post.vote_by voter: self
  end

  def downvote(post)
    post.downvote_from self
  end

  def unvote(post)
    post.unvote_by self
  end

end
