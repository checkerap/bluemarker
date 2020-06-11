Rails.application.routes.draw do
  root 'home#index'
  
  resources :contacts
  resources :categories
  resources :events
  resources :news
  resources :papers
  resources :paper_files
  resources :talks
  resources :categories
  resources :contacts
  devise_for :users
  
  get 'home' => 'home#index'
  get 'private' => 'home#private'
  
  # Users
    # Pages
    get 'users' => 'users#index'
    get 'users/upload' => 'users#upload'
    get 'users/new' => 'users#new' 
    get 'users/edit/:id' => 'users#edit', as: :edit_user
    get 'users/:id' => 'users#show'
    # Actions
    post 'create_user' => 'users#create', as: :create_user   
    post 'update_user/:id' => 'users#update', as: :update_user
    delete 'delete_user/:id' => 'users#destroy', as: :destroy_user
    post 'import' => 'users#import'
  
  # Events
    # Event talks
    get '/events/:id/talks' => 'events#talks'
  
  # Thredded
  mount Thredded::Engine => '/forum'
end
