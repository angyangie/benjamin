Rails.application.routes.draw do
  root 'application#index'
  
  post '/accounts', to: 'application#show', as: 'accounts'

  resources :users, except: [:new, :create]

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create', as: 'create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

end
