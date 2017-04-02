class PostSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes(
    :body,
    :user,
    :upvote_count,
    :permissions,
    :visibility,
    :media,
    :created_at
  )

  def post
    @post ||= object
  end

  def type
    post.class.name
  end

  def user
    #anonymous? ? post.serialized_user(:anonymous) : post.serialized_user
    post.serialized_user
  end

  def created_at
    time_ago_in_words(post.created_at)
  end

  def media
    nil
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

      if post.user_id == user.id
        perms[:editable] = true
        perms[:hideable] = true
      end

      if user.voted_up_on? post
        perms[:voted_for] = true
      end

    end

    perms
  end

end
