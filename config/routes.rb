Rails.application.routes.draw do
  resources :home, only: :index

  root 'home#index'
end
