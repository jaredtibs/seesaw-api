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

  #TODO might have to separate this out into its own endpoint so you can apply
  # filters and paginate, just pulling through the associaton in the serializer is not going to cut it
  # could possibly add a filter param
  def relationships
    {
      "posts": object.serialized_posts
    }
  end

end
