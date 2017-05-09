class NotificationSerializer < ActiveModel::Serializer

  attributes(
    :user,
    :initiator,
    :body,
    :checked
  )

  def notification
    @notification ||= object
  end

  def user
    notification.serialized_user(:receiver)
  end

  def initiator
    notification.serialized_user(:initiator)
  end

end
