class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :recoverable

  #mount_uploader :avatar, AvatarUploader

  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :posts

  validates :username, presence: true, length: { minimum: 2 },
            uniqueness: { case_sensitive: false }, on: [:create, :update]

  validates_uniqueness_of :email

  acts_as_voter

  def upvote(post)
    post.vote_by voter: self
    Post.increment_counter(:upvote_count, post.id)
  end

  def unvote(post)
    post.unvote_by self
    Post.decrement_counter(:upvote_count, post.id)
  end

end
