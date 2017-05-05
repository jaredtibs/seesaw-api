class FactualApi

  BASE_URL = "https://api.factual.com"

  class << self

    def categories_by_id(ids)
    end

    def place_info(query_params={})
      response = get(place_info_path, query_params)
      JSON.parse(response.body)
    end

    def get(path, parameters)
      parameters.merge!({KEY: api_key})
      connection.get path, parameters, headers
    end

    def connection
      Faraday.new(self::BASE_URL)
    end

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end

    private

    def api_key
      Rails.application.secrets.factual_api_key
    end

    def categories_path
      "/categories"
    end

    def place_info_path
      "/search/places-us"
    end

  end
end
