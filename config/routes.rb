Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  post "items/confirm" => "items#confirm"

  resources :items, only: [:index, :new, :create, :update, :show]

  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end


end
