Rails.application.routes.draw do

  resources :recipes do
    resources :ingredients
  end
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'items#index'

  # Static Pages
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'

  # User Handling
  resources :users
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
