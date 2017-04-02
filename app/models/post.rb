class Post < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :location

  # currently unused
  has_one :media

  scope :active, -> { where(hidden: false) }

  mount_uploader :media, MediaUploader

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

end
