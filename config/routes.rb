require "sidekiq/web"
require "sidekiq-status/web"

Rails.application.routes.draw do
  root "home_page#home"

  get "/history", to: "history#index"
  get "/management", to: "home_page#management"
  post "/rate", to: "rater#create", as: "rate"
  get "search(/:search)", to: "search#index", as: "search"
  get "/download/chapter/:id", to: "download#chapter", as: "download_chapter"
  get "/export/story/:id", to: "download#export_story", as: "export_story"
  get "/export_status", to: "download#export_status"
  get "/download/story/:id", to: "download#story"

  devise_for :users, controllers: {registrations: "users/registrations"}
  resources :stories do
    member do
      get "chapters", to: "chapters#index"
    end
  end
  resources :chapters
  resources :categories, only: %i(index show)
  resources :follows, only: %i(index create destroy)
  resources :notifications, only: %i(destroy update)
  resources :comments, only: %i(create destroy)
  mount ActionCable.server => "/cable"
  mount Sidekiq::Web, at: "/sidekiq"
end
