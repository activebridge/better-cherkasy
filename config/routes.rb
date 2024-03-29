Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :events, except: :new do
    collection do
      get :mine
      get :subscriptions
    end
    resources :comments, only: [:index, :create, :destroy]
    resources :photos, only: [:create]
  end

  resources :home, only: :index
  resources :users, only: :create
  resources :sessions, only: :show
  resources :event_votes, only: :update
  resources :subscriptions, only: [:create, :destroy]
  resources :tags, only: :index
  resources :omniauth_callbacks do
    get :odnoklassniki
  end

  get '/auth/odnoklassniki/callback'=>'omniauth_callbacks#odnoklassniki'
  root 'home#index'
end
