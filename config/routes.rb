Rails.application.routes.draw do

  root 'static#home'
  get '/home', to: 'static#help'
  get '/about', to: 'static#about'
  get '/signup', to: 'users#new'
end
