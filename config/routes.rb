Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root "posts#index"
  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :users, only: [:index,:new, :show, :edit, :update]
  resources :posts do
    collection do
      get 'search'
    end
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
end
