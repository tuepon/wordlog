# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  root to: 'home#index'

  get 'about', to: 'pages#about'

  resources :posts
  post "toggle_like", to: "likes#toggle_like", as: :toggle_like

  resources :users, only: [:show]
  resources :words do
    collection do
      post :import
      get :export
    end
    
  end
end
