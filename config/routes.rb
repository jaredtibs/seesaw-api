Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, skip: :all
  devise_scope :user do
    post 'registrations'  => 'registrations#create'
    post 'sessions'       => 'sessions#create'
    get  'sessions'       => 'sessions#show'
  end
end
