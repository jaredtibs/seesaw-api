class FetchLocationImage
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(location_id)
    location = Location.find_by id: location_id

    if location
      # fetch image
    end

  end
