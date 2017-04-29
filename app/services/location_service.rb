class LocationService
  class << self

    # unused
    def find_current_location(coordinates)
      Location.near(coordinates, 0.0621371).first
    end

    def find_or_create_factual_location(options={})
      options.symbolize_keys!
      location = Location.find_or_create_by place_id: options[:place_id]
      location = Location.new unless location.present?

      location.name = options[:name]
      location.latitude  = options[:latitude]
      location.longitude = options[:longitude]
      location.save
      location
    end

    # takes coordinates, needs to reverse geocode to get the address
    # might need to add a "raw" flag so that you can have specific logic for
    # this type of location
    def find_or_create_raw_location(lat, long)
      location = Location.find_or_create_by latitude: lat, longitude: long
      location = Location.new unless location.present?
      #location.raw = true
      location.save
      location
    end

    def nearby_locations(coordinates)
      FactualApi.nearby_places(coordinates)
    end

    #TODO
    def unseen_posts_for_user?(location, user)
      return false if location.nil?
      #...

    end


  end
end
