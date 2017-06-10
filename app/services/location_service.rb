class LocationService
  class << self

    def find_or_create_factual_location(options={})
      options.symbolize_keys!
      location = Location.find_by place_id: options[:place_id]
      location = Location.new unless location.present?

      location.latitude  = options[:latitude]
      location.longitude = options[:longitude]
      location.name = options[:name]
      location.save
      location
    end

    # creates a raw location, i.e. location not indexed by Factual Inc.
    # reverse geocodes from lat, long to pull address after create
    def find_or_create_raw_location(lat, long)
      Location.find_or_create_by latitude: lat, longitude: long
    end

    def visit_for_user(user, location)
      user_location = UserLocation.find_or_create_by user_id: user.id, location_id: location.id
      user_location.last_here = DateTime.now
      user_location.save
    end

    def unseen_posts_for_user?(location, user)
      user_location = UserLocation.find_by user_id: user.id, location_id: location.id

      if user_location.nil?
        location.posts.any? ? true : false
      else
        posts = Post.where('created_at > ?', user_location.last_here)
        posts.any? ? true : false
      end
    end

  end
end
