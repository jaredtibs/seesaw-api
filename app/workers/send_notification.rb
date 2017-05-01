class SendNotification
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform(options)
    options.symbolize_keys!

    case options[:type]
    when :upvote
      post = Post.find options[:post_id]
      user = User.find options[:user_id]
      Notification.create(
        user_id: post.user_id,
        body: "#{user.username} upvoted your post"
      )
    end

  end
end
