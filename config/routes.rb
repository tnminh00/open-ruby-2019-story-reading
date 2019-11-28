Rails.application.routes.draw do
  root "home_page#home"

  get "/signup", to: "users#new"

  resource :users
end
