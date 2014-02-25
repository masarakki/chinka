Chinka::Application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'callbacks' }
  root "top#index"
end
