class SendNotification
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(options)
    options.symbolize_keys!

    case options[:type].to_sym
    when :upvote
      # push notif logic goes here
      post = Post.find options[:post_id]
      user = User.find options[:user_id]
      unless post.user_id == user.id
        Notification.create(
          kind: 1,
          receiver_id: post.user_id,
          initiator_id: user.id,
          body: "upvoted your post."
        )
      end
    end

  end
end
