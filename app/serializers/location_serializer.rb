class LocationSerializer < ActiveModel::Serializer

  attributes(
    :name,
    :categories,
    :latitude,
    :longitude,
    :city,
    :region,
    :postal_code,
    :country,
    :post_count,
    :vote_count,
    :photo_count
  )

  has_many :posts

  def self_link
    nil
  end

  def location
    @location ||= object
  end

  def type
    location.class.name
  end

  def post_count
    location.cached_post_count
  end

  #TODO might have to separate this out into its own endpoint so you can apply
  # filters and paginate, just pulling through the associaton in the serializer is not going to cut it
  # could possibly add a filter param
  #def relationships
  #  {
  #    "posts": object.serialized_posts
  #  }
  #end

end
