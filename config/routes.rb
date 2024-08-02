# frozen_string_literal: true

require 'sidekiq'

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index]

  root 'home#index'
  get 'about', to: 'pages#about'
  
  resources :posts, only: %i[show index]
  resources :posts
  post "toggle_like", to: "likes#toggle_like", as: :toggle_like

  resources :words, only: %i[show index new create edit update destroy]
  resources :words do
    collection { post :import }
  end
end
