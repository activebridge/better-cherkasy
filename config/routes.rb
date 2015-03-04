Rails.application.routes.draw do
  resources :events

  resources :home, only: :index
  resources :users, only: :create

  root 'home#index'
end
