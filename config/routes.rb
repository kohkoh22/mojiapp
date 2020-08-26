Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
end
