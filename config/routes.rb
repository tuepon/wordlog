# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index]

  root 'home#index'
  get 'about', to: 'pages#about'

  resources :posts

  post "toggle_like", to: "likes#toggle_like", as: :toggle_like

  resources :words do
    collection { post :import }
  end
end
