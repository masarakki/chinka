Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'callbacks' }
  resources :erasers
  resources :users, only: [:show] do
    resources :tweets, only: [:destroy], to: 'users#tweets'
  end

  namespace :api, defaults: { format: 'json' } do
    get 'users/me', to: 'users#me', as: :me
    get 'twitter/search', to: 'twitter#search'
  end
  root 'top#index'
end
