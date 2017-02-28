class UserSerializer < ActiveModel::Serializer
  attributes(
    :email,
    :username,
    :avatar
  )

  def type
    object.class.name
  end

  def self_link
    nil
  end

end
