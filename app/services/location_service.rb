class LocationService
  class << self

    def find_or_create_nearest_location(coordinates)
      nearest_location = Location.near(coordinates).first
      return nearest_location if nearest_location

      Location.create(
        latitude: coordinates[0],
        longitude: coordinates[1]
      )
    end

  end
end
