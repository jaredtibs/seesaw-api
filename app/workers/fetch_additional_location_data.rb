class FetchAdditionalLocationData
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(place_id)
    location = Location.find_by place_id: place_id
    if location
      data = Factual::Api.place_info({q: location.place_id})
      data = data["response"]["data"][0] rescue nil
      if data
      end
    end
  end
end
