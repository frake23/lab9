Rails.application.routes.draw do
  root to: 'home#index'
  post '/calc', to: 'home#calc'
  post '/', to: 'home#calc'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
