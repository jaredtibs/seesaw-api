class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :posts

  geocoded_by :address, :latitude  => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude

  #after_validation :geocode
  #after_validation :reverse_geocode

  after_commit :fetch_location_data, on: :create

  def posts_meta
    {
      post_count: posts.count,
      vote_count: 0,
      photo_count: 0
    }
  end

  def coordinates
    [latitude, longitude]
  end

  # deprecated
  def serialized_posts
    ActiveModelSerializers::SerializableResource.new(
      posts.active.order('created_at desc'),
      meta: {total_count: posts.active.count},
      each_serializer: PostSerializer
    )
  end

  def fetch_location_data
    FetchAdditionalLocationData.perform_async self.id
  end
end
