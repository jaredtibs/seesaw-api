class FetchAdditionalLocationData
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(location_id)
    FetchFactualMetaData.perform_async location_id
    FetchLocationImage.perform_async location_id
  end
end
