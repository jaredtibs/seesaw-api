class FetchLocationData
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(place_id)
    location = Location.find_by place_id: place_id
    if location
      data = Factual::Api.place_info({q: place_id})
      data = data["response"]["data"][0] rescue nil
      if data
        location.update_attributes(
          latitude: data["latitude"],
          longitude: data["longitude"],
          country: data["country"],
          postal_code: data["postcode"],
          region: data["region"],
          categories: data['category_labels']
        )
      end
    end
  end
end
