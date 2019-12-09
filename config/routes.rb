Rails.application.routes.draw do
  root "home_page#home"

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :stories
  resources :chapters
  resources :search, only: :index
  resources :categories, only: %i(index show)
end
