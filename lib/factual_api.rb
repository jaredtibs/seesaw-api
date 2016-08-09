require 'factual'

class FactualApi

  def self.nearby_places(coordinates, meters=100)
    client.table("places-us").geo(
      "$circle" => {
        "$center" => coordinates,
        "$meters" => meters,
        "$sort"   => {
          "distance" => 1000,
          "placerank" => 100
        }
      }
    ).rows
  end

  def self.client
    @client ||= Factual.new(
      Rails.application.secrets.factual_api_key,
      Rails.application.secrets.factual_api_secret
    )
  end
end
