class PostSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes(
    :body,
    :user,
    :upvote_count,
    :permissions,
    :visibility,
    :created_at
  )

  def type
    object.class.name
  end

  def user
    #anonymous? ? object.serialized_user(:anonymous) : object.serialized_user
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

    user = current_user

    if user

      if object.user_id == user.id
        perms[:editable] = true
        perms[:hideable] = true
      end

      if user.voted_up_on? object
        perms[:voted_for] = true
      end

    end

    perms
  end

  def self_link
    nil
  end

end
