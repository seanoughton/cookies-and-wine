Rails.application.routes.draw do


  root 'users#new'

  resources :ratings
  resources :comments

  resources :pairings do
    resources :ratings
    resources :comments
    resources :cookies
  end

  resources :wines
  resources :cookies

  resources :users do
    resources :pairings
    resources :comments
    get 'most_recipes' => 'users#show'
  end

  resources :welcome

  get 'home' => 'welcome#home'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create'

  post '/sort' => 'pairings#sort'
  get '/sort' => 'pairings#sort'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
