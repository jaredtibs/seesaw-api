class Notification < ApplicationRecord
  belongs_to :user

  def serialized_user
    if user
      ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer)
    else
      {}
    end
  end

end
