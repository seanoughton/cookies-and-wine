Rails.application.routes.draw do
  resources :comments
  resources :pairings
  resources :wines
  resources :cookies
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
