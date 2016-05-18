Rails.application.routes.draw do
  
  root 'application#index'
  
  post '/accounts', to: 'plaidapi#add_account'

end
