Rails.application.routes.draw do
  root 'welcome#index'

  namespace :api do
    namespace :v1 do

      devise_for :users, skip: :all
      devise_scope :user do
        post 'registrations'  => 'registrations#create'
        post 'sessions'       => 'sessions#create'
        get  'sessions'       => 'sessions#show'
        delete '/sessions'    => 'sessions#destroy'
      end

    end
  end
end
