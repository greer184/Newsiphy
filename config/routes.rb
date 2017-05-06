Rails.application.routes.draw do

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
end
