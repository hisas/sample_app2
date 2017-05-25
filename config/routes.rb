Rails.application.routes.draw do
  root   "static_pages#home"

  get    "/help",    to: "static_pages#help"
  get    "/about",   to: "static_pages#about"
  get    "/contact", to: "static_pages#contact"
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"

  resources :users do
    member do
      get :following,
          :followers,
          :microposts,
          :microposts_feed
    end
    collection do
      get :search
    end
  end

  resources :microposts, only: %i(create destroy) do
    resources :likes, only: %i(create destroy)
    collection do
      get :search
    end
  end

  resources :settings, only: :index
  namespace :settings do
    resources :notifications, only: :index
    resource  :notifications, only: %i(create update)
  end

  resources :account_activations, only: :edit
  resources :password_resets,     only: %i(new create edit update)
  resources :relationships,       only: %i(create destroy)

  namespace :api, format: :json do
    namespace :v1 do
      resources :users
    end
  end
end
