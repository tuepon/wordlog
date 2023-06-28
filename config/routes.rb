Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :words, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :words do
    collection { post :import }
  end
end
