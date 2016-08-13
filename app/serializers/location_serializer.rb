class LocationSerializer
  include JSONAPI::Serializer

  attributes(
    :name,
    :categories,
    :latitude,
    :longitude,
    :city,
    :region,
    :postal_code,
    :country
  )

  has_many :posts

  def self_link
    nil
  end

  def type
    object.class.name
  end

  def relationships
    {
      "posts": object.serialized_posts
    }
  end

end
