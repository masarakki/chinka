Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'callbacks' }
  resources :erasers
  resources :users, only: [:show] do
    resources :tweets, only: [:destroy], to: 'users#tweets'
  end
  root 'top#index'
end
