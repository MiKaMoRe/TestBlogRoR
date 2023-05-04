Rails.application.routes.draw do
  # Active admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  root "posts#index"
  
  resources :posts
end
