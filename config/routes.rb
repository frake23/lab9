Rails.application.routes.draw do
  resources :users
  root to: 'home#index'
  post '/', to: 'home#calc'
  get '/login', to: 'session#login'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
