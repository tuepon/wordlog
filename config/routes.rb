Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :words, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :words do
    collection { post :import }
  end
end
