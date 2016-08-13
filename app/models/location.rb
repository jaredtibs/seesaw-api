class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :posts

  geocoded_by :address, :latitude  => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude
#reverse_geocoded_by :latitude, :longitude do |obj, results|
  # if obj.raw?
#     if geo = results.first
#       obj.city = geo.city
#       obj.state = geo.state
#       obj.postal_code = geo.postal_code
#       obj.country = geo.country
#     end
  # end
#end

  after_validation :geocode
  after_validation :reverse_geocode

  after_commit :fetch_location_image, on: :create

  def coordinates
    [latitude, longitude]
  end

  def unseen_posts_for(user)
    #TODO
  end

  def serialized_posts
    JSONAPI::Serializer.serialize(
      posts.order('created_at desc'),
      meta: { count: posts.count },
      is_collection: true
    )
  end

  def fetch_location_image
    # google api?
  end
end
