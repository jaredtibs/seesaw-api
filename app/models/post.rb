class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location


  def serialized_user
    JSONAPI::Serializer.serialize(user)
  end
end
