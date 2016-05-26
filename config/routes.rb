Rails.application.routes.draw do

  root 'home#index'
  post '/users/piechart', to: 'users#piechart'



  resources :users, except: [:new, :create] do
    resources :transactions, only: [:index, :show, :edit, :update]
    resources :accounts, only: [:index]
    resources :budgets, except: [:index]
  end

  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create', as: 'create'

  # This seems redundant
  get '/update/:id', to: 'users#edit', as: 'edit'
  patch '/update/:id', to: 'users#update', as: 'user_update'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  post '/users/:id/add_account', to: 'plaidapi#add_account'
  patch '/user/:id/update_accounts', to: 'plaidapi#update_accounts'  

  get 'graph/index'
  get 'graph/data', :defaults => { :format => 'json' }
  post 'graph/data', to: 'graph#data'

  get '/users/data', :defaults => { :format => 'json' }

end
