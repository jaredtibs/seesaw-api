class Post < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :location
  has_one :media

  scope :active, -> { where(hidden: false) }

  def serialized_user
    if user
      ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer)
    else
      {}
    end
  end

end
