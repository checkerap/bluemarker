Rails.application.routes.draw do
  resources :posts
  resources :topics
  resources :message_boards
  root 'home#index'
  
  resources :contacts
  resources :categories
  resources :events
  resources :news
  resources :papers
  resources :paper_files
  resources :talks
  # resources :categories
  # resources :contacts
  resources :message_boards
  resources :topics
  resources :posts
  
  devise_for :users
  
  get 'home' => 'home#index'
  get 'private' => 'home#private'
  
  # Users
    # Pages
    get 'users' => 'users#index'
    get 'users/upload' => 'users#upload'
    get 'users/new' => 'users#new' 
    get 'users/change_password/:id' => 'users#change_password', as: :change_password
    get 'users/edit/:id' => 'users#edit', as: :edit_user
    get 'users/:id' => 'users#show'
    # Actions
    post 'create_user' => 'users#create', as: :create_user   
    post 'update_user/:id' => 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destroy', as: :destroy_user
    post 'import' => 'users#import'
    post 'update_password/:id' => 'users#update_password', as: :update_password
  
  # Events
    # Event talks
    get '/events/:id/talks' => 'events#talks'
    get '/events/:id/users' => 'events#users'
end
