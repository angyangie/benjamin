Rails.application.routes.draw do

  root 'home#index'
  resources :users, except: [:new, :create]

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create', as: 'create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  post '/users/accounts', to: 'plaidapi#add_account'

  get 'graph/index'
  get 'graph/data', :defaults => { :format => 'json' }

  get '/users/data', :defaults => { :format => 'json' }
end
