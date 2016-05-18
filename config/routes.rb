Rails.application.routes.draw do
  root 'application#index'
  post '/accounts', to: 'application#accounts'
  
end
