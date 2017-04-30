class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :posts

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.name = geo.address.split(",")[0]
      obj.city = geo.city
      obj.region = geo.state
      obj.postal_code = geo.postal_code
      obj.country = geo.country_code
    end
  end

  after_validation :reverse_geocode, if: :raw_location?
  after_commit :fetch_location_data, on: :create

  def raw_location?
    self.place_id.nil?
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
