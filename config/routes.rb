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
        put  'users/:id'       => 'users#update'
        post 'reset-password'  => 'users#reset_password'
        put  'reset-password'  => 'users#update_password'

        # locations
        get 'locations' => 'locations#check'
      end

    end
  end
end
