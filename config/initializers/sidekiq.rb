require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { namespace: "sidekiq" }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: "sidekiq" }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["admin", "seesaw!!1"]
end
