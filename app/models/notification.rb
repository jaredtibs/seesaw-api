class Notification < ApplicationRecord
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'receiver_id'
  belongs_to :initiator, :class_name => 'User', :foreign_key => 'initiator_id'

  scope :recent, -> { order('created_at desc') }

  enum kind: {
    "upvote" => 1
  }

  def serialized_user(type)
    user = type == :initiator ? initiator : receiver
    if user
      ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer)
    else
      {}
    end
  end

end
