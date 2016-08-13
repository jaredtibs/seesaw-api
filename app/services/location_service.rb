class LocationService
  class << self

    def find_current_location(coordinates)
      Location.near(coordinates, 0.0621371).first
      # or use factual to find nearby, attempt to match on id, if no match found,
      # create closest location from factual data
      # FactualApi.nearby_places(coordinates)
    end

    def find_or_create_current_location(coordinates)
      nearest_location = find_current_location(coordinates)

      if nearest_location.blank?
        factual_data = FactualApi.nearby_places(coordinates)
        if factual_data
          create_location_from_factual(factual_data.first)
        else
          create_raw_location(coordinates)
          # you will need to reverse geocode in this instance, possible flag it and then adjust revere geocode callback to only run if flagged
        end
      else
        nearest_location
      end
    end

    def create_location_from_factual(factual_data)
      data = factual_data.symbolize_keys

      Location.create(
        factual_id: data[:factual_id],
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

  end
end
