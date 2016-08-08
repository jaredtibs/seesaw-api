class UserSerializer
  include JSONAPI::Serializer

  attribute :email
  attribute :username

  attribute :last_signed_in do
    last_sign_in_at = object.last_sign_in_at
    if last_sign_in_at.present?
      object.last_sign_in_at.in_time_zone("Pacific Time (US & Canada)")
              .strftime("%m/%d/%y %l:%M%p")
    else
      "N/A"
    end
  end

  def type
    object.class.name
  end

  def self_link
    nil
  end

end
