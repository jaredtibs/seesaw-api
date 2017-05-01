class NotificationSerializer < ActiveModel::Serializer

  attributes(
  )

  def notification
    @notification ||= object
  end
end
