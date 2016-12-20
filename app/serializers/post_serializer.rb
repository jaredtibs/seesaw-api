class PostSerializer
  include JSONAPI::Serializer
  include ActionView::Helpers::DateHelper

  attributes(
    :body,
    :user,
    :upvote_count
  )

  attribute :created_at do
    time_ago_in_words(object.created_at)
  end

  def type
    object.class.name
  end

  def user
    object.serialized_user
  end

  def self_link
    nil
  end

end
