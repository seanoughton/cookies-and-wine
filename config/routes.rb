Rails.application.routes.draw do


  root 'users#new'

  resources :ratings
  resources :comments

  resources :pairings do
    resources :ratings
    resources :comments
  end

  resources :wines do
    resources :pairings
  end

  resources :cookies do
    resources :pairings
  end

  resources :users do
    resources :pairings
    resources :comments
    resources :cookies
    resources :wines
  end

  resources :welcome

  get 'home' => 'welcome#home', as: 'home'
  get 'login' => 'sessions#new', as: 'login'
  post 'login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create'

  post '/sort' => 'pairings#sort'
  get '/sort' => 'pairings#sort'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
