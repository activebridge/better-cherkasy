Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :events, except: [:new, :edit, :update] do
    resources :comments, only: [:index, :create, :destroy]
  end

  resources :home, only: :index
  resources :users, only: :create
  resources :sessions, only: :show
  resources :event_votes, only: :update
  resources :subscriptions, only: [:create, :destroy]
  resources :tags, only: :index

  root 'home#index'
end
