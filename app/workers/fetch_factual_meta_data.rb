class FetchFactualMetaData
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(location_id)
    location = Location.find_by id: location_id

    if location
      data = ::Factual::Api.place_info(q: location.place_id)
      data = data["response"]["data"][0] rescue nil
      if data
        location.update_attributes(
          categories: data["category_labels"].flatten,
          address: data["address"],
          country: data["country"],
          city: data["locality"],
          region: data["region"],
          postal_code: data["post_code"]
        )
      end
    end
  end

end
