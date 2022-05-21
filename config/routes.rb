Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :notifications, only: [:index, :show, :create, :update]
      resources :users, only: [:show]
      resources :assignments, only: [:show, :create, :update]
    end
  end
end
