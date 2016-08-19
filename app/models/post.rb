class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location

  acts_as_votable

  def serialized_user
    JSONAPI::Serializer.serialize(user)
  end
end
