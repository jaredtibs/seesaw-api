class PostSerializer
  include JSONAPI::Serializer

  attributes(
    :created_at,
    :body,
    :user
  )

  def type
    object.class.name
  end

  def user
    object.serialized_user
  end

  def self_link
    nil
  end

end
