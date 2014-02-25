Chinka::Application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'callbacks' }
  resources :erasers
  root "top#index"
end
