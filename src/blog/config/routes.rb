Rails.application.routes.draw do
  get "/debugtest", to: "debugtest#index"
  root "articles#index"

  get "/articles", to: "articles#index"
  get "/articles/:id", to: "articles#show"
end
