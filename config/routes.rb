require 'sidekiq/web'

Rails.application.routes.draw do
  root 'welcome#index'

  scope module: :api do
    scope module: :v1 do

      scope 'api/v1' do

        devise_for :users, skip: :all
        devise_scope :user do
          post 'registrations'  => 'registrations#create'
          post 'sessions'       => 'sessions#create'
          get  'sessions'       => 'sessions#show'
          delete '/sessions'    => 'sessions#destroy'
        end

        # users
        get  'users'           => 'users#index'
        get  'users/:username' => 'users#show'
        get  'search/users'    => 'users#search'
        put  'user'            => 'users#update'
        put  'user/email'      => 'users#update_email'
        put  'reset-password'  => 'users#update_password'
        post 'user/avatar'     => 'users#update_avatar'
        post 'reset-password'  => 'users#reset_password'

        # locations
        get 'locations/ping'       => 'locations#ping'
        get 'locations/:id/posts'  => 'locations#posts'
        post 'locations/current'   => 'locations#show'
        post 'locations/:id/posts' => 'locations#create_post'

        # posts
        post 'posts/:id/report'   => 'posts#report'
        post 'posts/:id/upvote'   => 'posts#upvote'
        post 'posts/:id/downvote' => 'posts#downvote'
        post 'posts/:id/unvote'   => 'posts#unvote'
        get 'posts/:id/upvotes'   => 'posts#upvotes'
        get 'posts/:id/downvotes' => 'posts#downvotes'

        # notifications
        get 'user/notifications' => 'notifications#index'
        put 'user/notifications' => 'notifications#mark_as_read'
      end

    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
