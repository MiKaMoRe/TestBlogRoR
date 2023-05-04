Rails.application.routes.draw do
  # Active admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  root "posts#index"
  
  resources :posts do
    resources :comments, only: %i[create]
  end
end
