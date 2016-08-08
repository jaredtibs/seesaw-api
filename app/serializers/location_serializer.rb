class LocationSerializer
  include JSONAPI::Serializer

  attribute :name
  has_many :posts

  def self_link
    nil
  end

 # def relationships
 #   {
 #     "posts": object.serialized_posts
  #  }
  #end

end
