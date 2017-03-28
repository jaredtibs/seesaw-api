class LocationSerializer < ActiveModel::Serializer

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

  def post_count
  end

  def vote_count
  end

  def photo_count
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
