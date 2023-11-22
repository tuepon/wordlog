Rails.application.routes.draw do
  # get 'home/index'
  devise_for :users
  root 'home#index'
  get 'about', to: 'pages#about'
  resources :words, only: %i[show index new create edit update destroy]
  resources :words do
    collection { post :import }
  end
  resources :users, only: %i[show index]
end
