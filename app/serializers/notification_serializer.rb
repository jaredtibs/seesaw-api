class NotificationSerializer < ActiveModel::Serializer

  attributes(
    :user,
    :body,
    :checked
  )

  def notification
    @notification ||= object
  end

  def user
    notification.serialized_user
  end

end
