class Post < ApplicationRecord
  acts_as_votable

  belongs_to :user
  belongs_to :location
  has_one :media

  def serialized_user
    JSONAPI::Serializer.serialize(user)
  end
end
