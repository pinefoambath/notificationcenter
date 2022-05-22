Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      #Devise routes for API clients (custom sessions only)
      devise_scope :user do 
        post 'login', to: 'user_sessions#create', as: 'login'
      end
      put 'users/update', to: 'users#update'

      resources :notifications, only: [:index, :show, :create, :update]
      resources :users, only: [:show]
      resources :assignments, only: [:create, :update]
      get "assignments/check_read", to: "assignments#check_read"
    end
  end
end
