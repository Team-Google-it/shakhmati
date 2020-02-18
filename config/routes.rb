Rails.application.routes.draw do
  devise_for :users
  root 'games#index'

  resources :pieces, only: [:show, :update]
  resources :games, only: [:new, :create, :update, :show, :destroy]
  resources :pieces, only: [:show, :update] do
    put 'promote' => 'pieces#promote'
  end
  resources :users, only: :show

  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get]
  match '/auth/failure', :to => 'sessions#failure', via: [:get]
end
