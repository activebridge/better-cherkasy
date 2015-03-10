Rails.application.routes.draw do
  resources :events

  resources :home, only: :index
  resources :users, only: :create
  resources :sessions, only: :show
  resources :event_users, only: :update
  resources :subscriptions, only: [:create, :destroy]

  root 'home#index'
end
