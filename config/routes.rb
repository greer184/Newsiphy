Rails.application.routes.draw do

  get 'sessions/new'

  # Feed Management
  resources :feeds do
  end

  # Entries Management
  get 'entries/index'
  get 'entries/show'

  # Homepage Management
  root 'entries#index'
  get '/about', to: 'static#about'
  get '/curation', to: 'static#curation'

  # User Management
  get '/signup', to: 'users#new'
  resources :users

  # Session Management
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
end
