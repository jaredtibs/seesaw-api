class User < ApplicationRecord
  devise :database_authenticatable, :trackable, :recoverable

  mount_uploader :avatar, AvatarUploader

  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :posts

  validates :username, presence: true, length: { minimum: 2 },
            uniqueness: { case_sensitive: false }, on: [:create, :update]

  validates_uniqueness_of :email
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  acts_as_voter

  def self.find_by_email_or_username(login)
    where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
  end

  def image_data=(data)
    # decode data and create stream on them
    io = CarrierStringIO.new(Base64.decode64(data))
    self.avatar = io
  end

  def upvote(post)
    post.vote_by voter: self
    Post.increment_counter(:upvote_count, post.id)
    Location.increment_counter(:cached_votes_count, post.location.id)
  end

  def unvote(post)
    post.unvote_by self
    Post.decrement_counter(:upvote_count, post.id)
    Location.decrement_counter(:cached_votes_count, post.location.id)
  end

  def report(post)
    unless post.reported_by.include?(self.id)
      post.reported_by |= [self.id]
      if post.reported_by.size >= 3
        post.hidden = true
      end
      post.save
    end
  end

end

class CarrierStringIO < StringIO
  def original_filename
    # the real name does not matter
    "avatar.jpeg"
  end

  def content_type
    # this should reflect real content type, but for this example it's ok
    "image/jpeg"
  end
end
