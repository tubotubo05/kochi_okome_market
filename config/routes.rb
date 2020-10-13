Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  

  resources :items, only: [:index, :new, :create, :update, :show] do
    resources :comments,only:[:new,:create,:destroy]
  end

  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end


end
