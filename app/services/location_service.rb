class LocationService
  class << self

    # unused
    def find_current_location(coordinates)
      Location.near(coordinates, 0.0621371).first
    end

   # example response
   # {
   #   "name":"Denny's",
   #   "place_id": "84367f20-a94d-4ca3-899b-a13977791ccc",
   #   "placerank": 75,
   #   "distance": 29.279483443232,
   #   "chain_id": "441411a9-2154-4e52-88ba-b6ac20c83401",
   #   "confidence": 0.301628212288316
   # }
    def find_or_create_current_location(options={})
      options.symbolize_keys!
      location = Location.find_or_create_by place_id: options[:place_id]
      location = Location.new unless location.present?

      location.name = options[:name]
      location.latitude  = options[:latitude]
      location.longitude = options[:longitude]
      location.save
      location
    end

    # unused
    def create_location_from_factual(factual_data)
      data = factual_data.symbolize_keys

      Location.create(
        place_id: data[:place_id],
        latitude: data[:latitude],
        longitude: data[:longitude],
        postal_code: data[:postcode],
        city: data[:locality],
        region: data[:region],
        country: data[:country],
        name: data[:name],
        categories: data[:category_labels].flatten.uniq
      )

      # possibly seed other locations after this.
    end

    def create_raw_location(coordinates)

    end

    def nearby_locations(coordinates)
      FactualApi.nearby_places(coordinates)
    end

    def unseen_posts_for_user?(location, user)
      return false if location.nil?
      #...

    end


  end
end
