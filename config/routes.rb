# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users
  
  root 'home#index'
  get 'about', to: 'pages#about'
  
  post "toggle_like", to: "likes#toggle_like", as: :toggle_like
  
  resources :users, only: [:show, :index]
  resources :words do
    collection { post :import }
  end
end
