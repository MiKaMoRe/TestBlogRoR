Rails.application.routes.draw do
  # Active admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  # Defines the root path route ("/")
  # root "articles#index"
end
