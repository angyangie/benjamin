Rails.application.routes.draw do

  resources :users, except: [:new, :create]

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create', as: 'create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

  root 'home#index'

  post '/accounts', to: 'plaidapi#add_account'


end
