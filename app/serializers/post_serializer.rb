class PostSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes(
    :body,
    :user,
    :upvote_count,
    :permissions,
    :created_at
  )

  def type
    object.class.name
  end

  def user
    object.serialized_user
  end

  def created_at
    time_ago_in_words(object.created_at)
  end

  def permissions
    perms = {
      voted_for: false,
      editable: false,
      hideable: false,
      reportable: true
    }
  end

  def self_link
    nil
  end

end
