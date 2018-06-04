Rails.application.routes.draw do

  resources :ratings
  root 'users#new'
  resources :comments
  resources :pairings do
    resources :ratings
    resources :comments
  end
  resources :wines
  resources :cookies
  resources :users
  resources :welcome

  get 'home' => 'welcome#home'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
