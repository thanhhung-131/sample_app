# frozen_string_literal: true

Rails.application.routes.draw do
  # static pages
  root "static_pages#home"
  get "static_pages/help"

  # session
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # signup
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new create show)
end
