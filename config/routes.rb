Rails.application.routes.draw do
  resources :events

  resources :home, only: :index
  resources :users, only: :create
  resources :sessions, only: :show

  root 'home#index'
end
