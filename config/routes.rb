Rails.application.routes.draw do
  root 'landing#index'
  
  resources :contacts
  resources :categories
  resources :events
  resources :news
  resources :message_boards
  resources :papers
  resources :paper_files
  resources :posts
  resources :talks
  resources :topics
  
  devise_for :users
  
  get 'home' => 'landing#index'
  
  get 'private' => 'home#private'
  
  # Users
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
  get '/events/:id/speakers' => 'events#speakers'
  get '/events/:id/attendees' => 'events#attendees'
end
