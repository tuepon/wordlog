Rails.application.routes.draw do
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
  get 'users/:id' => 'users#show'
end
