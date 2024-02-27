# frozen_string_literal: true

Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/help"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new create show)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
