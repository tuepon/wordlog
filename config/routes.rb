Rails.application.routes.draw do
  resources :posts
  devise_for :users
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  get 'about', to: 'pages#about'

  resources :words, only: %i[show index new create edit update destroy]

  resources :words do
    collection { post :import }
  end

  resources :users, only: %i[show index]

  post "toggle_like", to: "likes#toggle_like", as: :toggle_like

  resources :posts, only: %i[show index]
end
