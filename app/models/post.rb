class Post < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :location

  # currently unused
  has_one :media

  scope :active, -> { where(hidden: false) }

  enum visibility: {
    everyone: 1,
    direct: 2,
    anonymous: 3
  }

  def serialized_user
    if user
      ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer)
    else
      {}
    end
  end

  def serialized_media
    if media
      ActiveModelSerializers::SerializableResource.new(media)
    else
      {}
    end
  end

end
