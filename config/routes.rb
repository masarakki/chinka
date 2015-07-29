Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'callbacks' }

  namespace :api, defaults: { format: 'json' } do
    resource :user, only: [:show]
    resources :slaves, only: [:index, :destroy] do
      resources :tweets, only: [:index, :destroy]
    end
    resources :bosses, only: [:index, :create, :destroy]
    get 'twitter/search', to: 'twitter#search'
  end
  root 'top#index'
end
