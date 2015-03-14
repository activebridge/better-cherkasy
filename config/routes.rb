Rails.application.routes.draw do
  resources :events, except: [:new, :edit, :update] do
    resources :comments, only: [:index, :create]
  end

  resources :home, only: :index
  resources :users, only: :create
  resources :sessions, only: :show
  resources :event_users, only: :update
  resources :subscriptions, only: [:create, :destroy]
  resources :tags, only: :index

  root 'home#index'
end
