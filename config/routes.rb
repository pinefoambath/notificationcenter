Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :notifications, only: [:index, :show, :create, :update]
      resources :users, only: [:show]
      resources :assignments, only: [:create, :update]
      get "assignments/check_read", to: "assignments#check_read"
    end
  end
end
