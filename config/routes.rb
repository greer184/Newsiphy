Rails.application.routes.draw do
  root 'static#home'
  get '/home', to: 'static#help'
  get '/about', to: 'static#about'
  get '/curation', to: 'static#curation'
  get '/signup', to: 'users#new'
  resources :users
end
