Rails.application.routes.draw do
  devise_for :users
  root 'games#index'
  # mount ActionCable.server => "/cable"

  resources :pieces, only: [:show, :update]
  resources :games, only: [:new, :create, :update, :show, :destroy] do
    put 'promote' => 'pieces#promote'
  end
  resources :pieces, only: [:show, :update]
  resources :users, only: :show

  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get]
  match '/auth/failure', :to => 'sessions#failure', via: [:get]
end
