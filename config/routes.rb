Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'callbacks' }
  resources :erasers
  resources :users, only: [:show] do
    resources :tweets, only: [:destroy], to: 'users#tweets'
  end

  namespace :api, defaults: { format: 'json' } do
    resource :user, only: [:show]
    resources :bosses, only: [:index, :create, :destroy]
    get 'twitter/search', to: 'twitter#search'
  end
  root 'top#index'
end
