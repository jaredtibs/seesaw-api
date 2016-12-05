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
        put  'user'            => 'users#update'
        put  'user/email'      => 'users#update_email'
        post 'reset-password'  => 'users#reset_password'
        put  'reset-password'  => 'users#update_password'

        # locations
        get 'locations/ping'    => 'locations#ping'
        post 'locations/current' => 'locations#show'
        post 'locations/:location_id/posts' => 'locations#create_post'

        # posts
        post 'posts/:id/report'   => 'posts#report'
        post 'posts/:id/upvote'   => 'posts#upvote'
        post 'posts/:id/downvote' => 'posts#downvote'
        delete 'posts/:id/vote'   => 'posts#unvote'
        get 'posts/:id/upvotes'   => 'posts#upvotes'
        get 'posts/:id/downvotes' => 'posts#downvotes'
      end

    end
  end
end
