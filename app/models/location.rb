class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :posts

  geocoded_by :address, :latitude  => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude

  after_validation :geocode
  after_validation :reverse_geocode

  after_commit :fetch_location_image, on: :create

  def coordinates
    [latitude, longitude]
  end

  def serialized_posts
    JSONAPI::Serializer.serialize(
      posts.active.order('created_at desc'),
      meta: { count: posts.count },
      is_collection: true
    )
  end

  def fetch_image
    # google api?
  end
end
