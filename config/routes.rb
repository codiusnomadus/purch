Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :products
    resources :roles
    resources :reviews

    root to: "users#index"
  end

  devise_for :users
  root to: "pages#index"

  resources :products
  resources :reviews
  resources :posts
  resources :deals
end
