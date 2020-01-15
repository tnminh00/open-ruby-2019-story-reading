Rails.application.routes.draw do
  root "home_page#home"

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  put "/updatehistory", to: "history#update"
  get "/history", to: "history#index"
  get "/management", to: "home_page#management"
  post "/rate", to: "rater#create", as: "rate"
  get "search(/:search)", to: "search#index", as: "search"

  resources :users
  resources :stories do
    member do
      get "chapters", to: "chapters#index"
    end
  end
  resources :chapters
  resources :categories, only: %i(index show)
  resources :follows, only: %i(index create destroy)
  resources :notifications, only: %i(destroy update)
  mount ActionCable.server => '/cable'
end
