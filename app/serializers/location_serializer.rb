class LocationSerializer < ActiveModel::Serializer

  attributes(
    :place_id,
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

  def photo_count
    location.cached_photo_count
  end

  def vote_count
    location.cached_vote_count
  end

end
