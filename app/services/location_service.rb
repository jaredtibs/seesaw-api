class LocationService
  class << self

    def find_nearest_location(coordinates)
      Location.near(coordinates).first
    end

    def find_or_create_nearest_location(coordinates)
      nearest_location = find_nearest_location(coordinates)
      if nearest_location.blank?
        Location.create(
          latitude: coordinates[0],
          longitude: coordinates[1]
        )
      else
        nearest_location
      end
    end

  end
end
