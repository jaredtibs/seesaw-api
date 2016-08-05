class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  has_many :posts

  geocoded_by :latitude, :longitude
  reverse_geocoded_by :latitude, :longitude
  #after_validation :geocode
  #after_validation :reverse_geocode
end
