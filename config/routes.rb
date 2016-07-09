Rails.application.routes.draw do
  root 'home#index'

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create', as: 'create'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :users, except: [:index, :new, :create] do
    resources :transactions, only: [:index, :show, :edit, :update]
    resources :accounts
    resources :budgets, except: [:index]
    resources :goals

  end

  # Clean up on these next...
  post '/users/piechart', to: 'users#piechart'
  post '/users/linegraph', to: 'users#linegraph'

  get 'graph/index'
  get 'graph/data', :defaults => { :format => 'json' }
  post 'graph/data', to: 'graph#data'

  get '/users/data', :defaults => { :format => 'json' }

end

# Cleaned
  # get '/update/:id', to: 'users#edit', as: 'edit'
  # patch '/update/:id', to: 'users#update', as: 'user_update'
  # post 'accounts/create', to: 'accounts#create'
  # patch '/update_accounts', to: 'plaidapi#update_accounts'
