Rails.application.routes.draw do
  get "/debugtest", to: "debugtest#index"
  root "articles#index"

  # Auto-generate CRUD routes for "/articles" urls
  resources :articles
end
