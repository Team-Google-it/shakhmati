Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  
  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get]
  match '/auth/failure', :to => 'sessions#failure', via: [:get]
end
