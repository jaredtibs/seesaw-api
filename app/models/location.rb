class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :posts

  geocoded_by :address, :latitude  => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.state = geo.state
      obj.postal_code = geo.postal_code
      obj.country = geo.country
    end
  end

  after_validation :geocode
  after_validation :reverse_geocode

  after_commit :fetch_location_name, on: :create

  def address
    [street, city, state, country, postal_code].compact.join(', ')
  end

  def address=(address_string)
  end

  def coordinates
    [latitude, longitude]
  end

  def unseen_posts_for(user)
    #TODO
  end

  def fetch_location_name
    # Google place details API
    # more info in geocoder documentation,
    # use api to fetch name, other potentially useful information about
    # a location
  end
end
