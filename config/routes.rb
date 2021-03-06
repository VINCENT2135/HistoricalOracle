Rails.application.routes.draw do
  root "pages#home"
  get "about", to: "pages#about"
  #resources :articles, only: [:show, :index, :new, :create, :edit, :update, destroy]
  #or
  resources :articles do
     resources :comments, only: [:show, :index, :new, :create, :destroy] 
  end

  get "signup", to: "users#new"

  #post 'users', to: 'users#create' this was needed to avoid that path error
  resources :users, except: [:new]
  get '/auth/:provider/callback', to: 'sessions#omniauth'  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  
  resources :categories




end
