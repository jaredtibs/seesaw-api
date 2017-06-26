class FlickrApi
  BASE_URL = ENV['FLICKR_BASE_URL']

  #https://www.flickr.com/services/api/flickr.photos.search.html
  #https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e693af3d1f05789dfaad53030d8ba9e2&lat=37.7994&lon=122.3950&format=rest&api_sig=b5935d841e55cb4281b9c84701422ae8
  class << self

    def location_image(query_params)
      response = get(photo_search_path, query_params)
      JSON.parse(response.body)
    end

    def get(path, parameters)
      parameters.merge!({api_key: api_key, method: method})
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

    def photo_search_path
      "/services/rest"
    end

    def method
      "flickr.photos.getRecent"
    end

    def api_key
      Rails.application.secrets.flickr_api_key
    end

  end
end
